class RelationshipsController < ApplicationController
  before_action :require_user

  def create
    @user = User.find_by_slug(params[:followed_id])
    current_user.follow!(@user) if current_user.can_follow?(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    relationship = Relationship.find_by(followed_id: @user)
    relationship.destroy if relationship.follower == current_user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
