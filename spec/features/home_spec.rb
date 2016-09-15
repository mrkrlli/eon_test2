require 'rails_helper'

describe "User goes to home page" do
  it "should see homepage header" do
    visit root_path

    expect(page).to have_css("h1", text: "Home Page")
  end
end
