require 'rails_helper'
require 'time'

describe "User makes a purchase", js: true do
  it "test" do
    user = create(:user,
                   email: "testuser@example.com",
                   password: "password",
                   password_confirmation: "password")
    visit purchase_path
    fill_in 'Email', with: "testuser@example.com"
    fill_in 'Password', with: "password"
    click_button 'Log in'

    expect(page.current_path).to eq purchase_path
    # click_button 'Pay with Card'
    # fill_in 'Email', with: "testuser@example.com"
    # fill_in 'Card number', with: "4242424242424242"
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
