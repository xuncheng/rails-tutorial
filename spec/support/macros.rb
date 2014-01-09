def set_current_user(user=nil)
  cookies[:remember_token] = (user || FactoryGirl.create(:user)).remember_token
end

def sign_up_with(name, email, password)
  visit sign_up_path
  fill_in "Name", with: name
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Password Confirmation", with: password
  click_button "Sign up"
end
