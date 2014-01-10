class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :require_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies[:remember_token] = @user.remember_token
      redirect_to @user, success: t("registrations.signed_up")
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, success: t("registrations.updated")
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by_slug(params[:id])
  end

  def correct_user
    redirect_to root_url unless current_user == find_user
  end
end
