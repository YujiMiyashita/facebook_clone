class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @usrs = User.all
  end

  def show
    @user = current_user
    #@follow = current_user.followed_users
    #@follower = current_user.followers
  end

end
