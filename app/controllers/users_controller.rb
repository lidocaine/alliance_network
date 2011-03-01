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
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Alliance Network!"
      redirect_to @user
    else
      @title = "Sign up"
      # Clear submitted password fields and render the sign-up form.
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
    
  rescue ActiveRecord::StatementInvalid
    redirect_to root_path
  end

end
