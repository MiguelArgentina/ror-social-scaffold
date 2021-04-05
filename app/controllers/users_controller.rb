class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    create_friendship(params[:friend_id]) if !friend_id? && !confirm_friendship?
    User.find(current_user.id).confirm_friend(User.find(params[:friend_id])) if confirm_friendship?
    User.find(current_user.id).reject_friend(User.find(params[:friend_id])) if reject_friendship?
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    create_friendship(params[:friend_id]) if !friend_id? && !confirm_friendship?
    User.find(current_user.id).confirm_friend(User.find(params[:friend_id])) if confirm_friendship?
    User.find(current_user.id).reject_friend(User.find(params[:friend_id])) if reject_friendship?
  end



  private

  def friend_id?
    params[:friend_id].nil?
  end

  def confirm_friendship?
    params[:confirm] == 'true'
  end

  def reject_friendship?
    params[:confirm] == 'false'
  end

  end
