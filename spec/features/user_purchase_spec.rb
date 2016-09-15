require 'rails_helper'

describe "User makes a purchase" do
  it "" do
    user = create(:user,
                   email: "testuser@example.com",
                   password: "password",
                   password_confirmation: "password")
    visit purchase_path

    fill_in 'Email', with: "test@exampletest.com"
    fill_in 'Password', with: "password"
    click_button 'Login'

    expect(page).to have_css("h2", text: "Send invitation")
  end
end

describe "User goes to purchase page"  do
  it "should see user login first" do
    visit purchase_path

    expect(page.current_path).to eq new_user_session_path
  end
end
