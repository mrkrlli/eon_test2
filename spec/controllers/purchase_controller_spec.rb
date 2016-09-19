require 'rails_helper'
require 'stripe_mock'
require 'pp'

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
      email = "testexample@example.com"
      plan_id = 'test_plan'
      plan = stripe_helper.create_plan(:id => plan_id, :amount => 1000)
      token = stripe_helper.generate_card_token()
      params = {stripeToken: token, stripeEmail: email}

      post :process_subscription, params: params

      expect(response).to redirect_to purchase_success_path
    end

    it 'creates a customer with correct email and plan' do
      email = "testexample@example.com"
      plan_id = 'test_plan'
      plan = stripe_helper.create_plan(:id => plan_id, :amount => 1000)
      token = stripe_helper.generate_card_token()
      params = {stripeToken: token, stripeEmail: email}

      post :process_subscription, params: params

      customers = @client.get_server_data(:customers)
      expect(customers.length).to eq(1)
      expect(customers["test_cus_3"][:email]).to eq(email)
      expect(customers["test_cus_3"][:plan]).to eq(plan_id)
    end
  end
end
