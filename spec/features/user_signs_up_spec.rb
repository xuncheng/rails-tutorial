require 'spec_helper'

feature "User signs up" do
  scenario "with valid attributes" do
    sign_up_with("Example User", "valid@example.com", "foobar")
    expect(page).to have_content("Example User")
  end

  scenario "with invalid attributes" do
    sign_up_with("Example User", "invalid_email", "foobar")
    expect(page).to have_content("Sign up")
  end
end
