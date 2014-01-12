class RelationshipsController < ApplicationController
  before_action :require_user

  def create
    @user = User.find_by_slug(params[:followed_id])
    current_user.follow!(@user) if current_user.can_follow?(@user)
    redirect_to @user
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.follower == current_user
    redirect_to relationship.followed
  end
end
