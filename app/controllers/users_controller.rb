class UsersController < ApplicationController
  before_action :find_user, only: [:show, :destroy, :following, :followers]
  before_action :require_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

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
    if @user.update(user_params)
      redirect_to @user, success: t("registrations.updated")
    else
      render :edit
    end
  end

  def destroy
    @user.destroy unless current_user == @user
    redirect_to users_url, success: t("registrations.destroyed")
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by(slug: params[:id])
  end

  def correct_user
    redirect_to root_url unless current_user == find_user
  end

  def require_admin
    redirect_to root_url unless current_user.admin?
  end
end
