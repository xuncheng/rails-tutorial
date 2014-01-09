module SessionsHelper
  def current_user
    User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end
end
