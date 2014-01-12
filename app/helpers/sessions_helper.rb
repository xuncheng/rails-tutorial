module SessionsHelper
  def require_user
    unless current_user
      store_location
      redirect_to login_url, notice: t("failure.unauthenticated")
    end
  end

  def current_user
    User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end

  def redirect_back_or(default)
    redirect_to session[:return_to] || default, success: t("sessions.signed_in")
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath if request.get?
  end
end
