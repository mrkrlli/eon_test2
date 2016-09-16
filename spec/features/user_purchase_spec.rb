require 'rails_helper'
require 'time'

describe "User makes a purchase", js: true do
  before (:each) do
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    Stripe::Customer.list.each do |customer|
      customer.delete
    end
  end

  it "sees subscription success page" do
    user = create(:user,
                   email: "testuser@example.com",
                   password: "password",
                   password_confirmation: "password")
    visit purchase_path
    fill_in 'Email', with: "testuser@example.com"
    fill_in 'Password', with: "password"
    click_button 'Log in'

    click_button 'Pay with Card'
    stripe_iframe = windows.last
    page.within_window stripe_iframe do
      fill_in 'Email', with: "testuser@example.com"
      fill_in 'Card number', with: "4242424242424242"
      fill_in 'MM / YY', with: "10 / 21"
      fill_in 'CVC', with: "111"
      click_button 'Pay $10.00'
      sleep(25)
    end

    expect(page.current_path).to eq purchase_success_path
  end

  after (:each) do
    Stripe::Customer.list.each do |customer|
      customer.delete
    end
  end
end

describe "User goes to purchase page"  do
  it "should see user login first" do
    visit purchase_path

    expect(page.current_path).to eq new_user_session_path
  end

  it "should see purchase page after logging in" do
    user = create(:user,
                   email: "testuser@example.com",
                   password: "password",
                   password_confirmation: "password")
    visit purchase_path

    fill_in 'Email', with: "testuser@example.com"
    fill_in 'Password', with: "password"
    click_button 'Log in'

    expect(page.current_path).to eq purchase_path
  end
end
