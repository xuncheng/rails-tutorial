class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if params[:session][:remember_me] == "1"
        cookies.permanent[:remember_token] = user.remember_token
      else
        cookies[:remember_token] = user.remember_token
      end
      redirect_to user
    else
      flash.now[:error] = "Invalid email and password combination."
      render :new
    end
  end
end
