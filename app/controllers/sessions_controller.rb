class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if params[:session][:remember_me] == "1"
        cookies.permanent[:remember_token] = user.remember_token
      else
        cookies[:remember_token] = user.remember_token
      end
      redirect_back_or root_url
    else
      flash.now[:error] = t("failure.invalid")
      render :new
    end
  end

  def destroy
    cookies[:remember_token] = nil
    redirect_to root_url, success: t("sessions.signed_out")
  end
end
