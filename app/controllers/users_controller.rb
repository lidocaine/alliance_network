class UsersController < ApplicationController
  def new
    @title = "Register"
  end
  
  def show
    @user = User.find(params[:id])
    @title = "#{@user.username}'s Profile"
  end
  
  def new
    @title = "Sign up"
    @user = User.new
  end

end
