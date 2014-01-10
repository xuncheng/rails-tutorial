class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if params[:session][:remember_me] == "1"
        cookies.permanent[:remember_token] = user.remember_token
      else
        cookies[:remember_token] = user.remember_token
      end
      flash[:success] = t("sessions.signed_in")
      redirect_to user
    else
      flash.now[:error] = t("failure.invalid")
      render :new
    end
  end

  def destroy
    cookies[:remember_token] = nil
    flash[:success] = t("sessions.signed_out")
    redirect_to root_url
  end
end
