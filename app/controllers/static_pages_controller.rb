class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if current_user
  end
end
