require 'rails_helper'

describe "Admin logs into admin interface" do
  it "should see admin dashboard" do
    admin = create(:admin_user,
                   email: "test@exampletest.com",
                   password: "password",
                   password_confirmation: "password")
    visit admin_root_path

    fill_in 'Email', with: "test@exampletest.com"
    fill_in 'Password', with: "password"
    click_button 'Login'

    expect(page).to have_css("h2", text: "Dashboard")
  end
end
