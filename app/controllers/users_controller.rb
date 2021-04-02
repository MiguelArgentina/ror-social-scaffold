class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    create_friendship(friend_id ||= params[:friend_id])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    create_friendship(friend_id ||= params[:friend_id])
  end
end
