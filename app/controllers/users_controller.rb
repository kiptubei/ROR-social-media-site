class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.select {|user| user.id != current_user.id}
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def invite
    user = User.find(params[:id])
    puts ''
    puts current_user.check_friendship_status(user)
    puts ''
    unless current_user.pending_friends.include?(user) || current_user.friend_requests.include?(user)
      current_user.friendships.create(user_id: current_user.id, friend_id: user.id)
      flash[:notice] = 'Freind Request sent'
      redirect_to user_path(user)
    else
      flash[:alert] = "You have a pending friend request"
    end
  end

  def confirm_friend
    user = User.find(params[:id])
    current_user.confirm_friend(user)
    flash[:notice] = "Frien request accepted"
    redirect_to root_path
  end
end
