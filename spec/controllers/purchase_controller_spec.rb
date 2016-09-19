require 'rails_helper'
require 'stripe_mock'
require 'pp'
require 'date'

describe PurchaseController do
  describe '#process_subscription' do
    let(:stripe_helper) {  StripeMock.create_test_helper }

    before(:each) do
      @client = StripeMock.start_client
    end

    after(:each) do
      @client.clear_server_data
      @client.close!
    end

    it 'redirects to purchase success page' do
      login_user
      user_email = "testuser@example.com"
      plan_id = 'test_plan'
      plan = stripe_helper.create_plan(:id => plan_id, :amount => 1000)
      token = stripe_helper.generate_card_token()
      params = {stripeToken: token, stripeEmail: user_email}

      post :process_subscription, params: params

      expect(response).to redirect_to purchase_success_path
    end

    it 'creates a customer with correct email and plan' do
      login_user
      user_email = "testuser@example.com"
      plan_id = 'test_plan'
      plan = stripe_helper.create_plan(:id => plan_id, :amount => 1000)
      token = stripe_helper.generate_card_token()
      params = {stripeToken: token, stripeEmail: user_email}

      post :process_subscription, params: params

      customers = @client.get_server_data(:customers)
      expect(customers.length).to eq(1)
      expect(customers["test_cus_3"][:email]).to eq(user_email)
      expect(customers["test_cus_3"][:plan]).to eq(plan_id)
    end

    it 'saves the customer id for the curent user' do
      login_user
      user_email = "testuser@example.com"
      plan_id = 'test_plan'
      plan = stripe_helper.create_plan(:id => plan_id, :amount => 1000)
      token = stripe_helper.generate_card_token()
      params = {stripeToken: token, stripeEmail: user_email}

      post :process_subscription, params: params

      customers = @client.get_server_data(:customers)
      customer_id = customers["test_cus_3"][:id]
      user = User.where(email: user_email).first
      expect(user.stripe_customer_id).to eq(customer_id)
    end

    it 'sets subscription flag to true' do
      login_user
      user_email = "testuser@example.com"
      plan_id = 'test_plan'
      plan = stripe_helper.create_plan(:id => plan_id, :amount => 1000)
      token = stripe_helper.generate_card_token()
      params = {stripeToken: token, stripeEmail: user_email}

      post :process_subscription, params: params

      user = User.where(email: user_email).first
      expect(user.subscription).to eq(true)
    end

    it 'sets active_until to 1 month from current date' do
      login_user
      user_email = "testuser@example.com"
      plan_id = 'test_plan'
      plan = stripe_helper.create_plan(:id => plan_id, :amount => 1000)
      token = stripe_helper.generate_card_token()
      params = {stripeToken: token, stripeEmail: user_email}

      post :process_subscription, params: params

      user = User.where(email: user_email).first
      expect(user.active_until).to eq(Date.today + 1.month)
    end

    def login_user
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user,
                     email: "testuser@example.com",
                     password: "password",
                     password_confirmation: "password")
      sign_in user
    end

  end
end
