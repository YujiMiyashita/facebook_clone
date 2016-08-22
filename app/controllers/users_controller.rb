class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    #@follow = current_user.followed_users
    #@follower = current_user.followers
  end

end
