class MicropostsController < ApplicationController
  before_action :require_user
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to root_url, success: "Micropost created!"
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url, success: "Micropost destroyed!"
  end

  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url unless @micropost
  end
end
