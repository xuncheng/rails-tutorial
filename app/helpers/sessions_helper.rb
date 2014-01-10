module SessionsHelper
  def require_user
    redirect_to sign_in_url, notice: t("failure.unauthenticated") unless current_user
  end

  def current_user
    User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end
end
