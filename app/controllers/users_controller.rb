class UsersController < ApplicationController
  before_filter :authenticate, :except => [:new, :create]
  before_filter :correct_user_or_admin, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]
  before_filter :defer, :only => [:new, :create]
  
  def show
    @user = User.find(params[:id])
    @title = "#{@user.username}'s Profile"
  end
  
  def index
    @title = "All Users"
    @users = User.all
  end
  
  def new
    @title = "Register"
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
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
    flash[:error] = "There was a problem submitting your registration. Please try again later."
    redirect_to root_path
  end
  
  def edit
    @title = "Edit User"
  end
  
  def update
    @user.update_attributes_nosave(params[:user])
    if @user.save
      flash[:success] = "Profile updated succesfully!"
      redirect_to @user
    else
      @title = "Edit Profile"
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if current_user?(@user)
      redirect_to users_path, :notice => "Admins can't delete themselves!"
    else
      @user.destroy
      flash[:success] = "User \"#{@user.username}\" destroyed."
      redirect_to users_path
    end
  end
  
  private
    # Might be needed later...
    #
    # def clean_params(params_hash)
    #   params_hash.delete(:update_type)
    # end

    def correct_user_or_admin
      @user = User.find(params[:id])
      redirect_to root_path unless current_user.admin? || current_user?(@user)
    end
  
    def admin_user
      redirect_to root_path unless current_user.admin?
    end

    def defer
      redirect_to current_user if signed_in?
    end

end
