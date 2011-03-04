class SessionsController < ApplicationController  
  def new
    @title = "Login"
  end
  
  def create
    user = User.authenticate(params[:session][:username],
                             params[:session][:password])
    
    if user.nil?
      flash[:error] = "Invalid username/password combination."
      @title = "Login"
      redirect_to signin_path
    else
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    flash[:notice] = "You have been logged out."
    redirect_to signin_path
  end

end
