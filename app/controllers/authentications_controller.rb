class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["rack.auth"]
    # OMNIAUTH-SIGNIN
    # Check to see if an authentication already exists, if one does, sign in the appropriate user.
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in via #{authentication.provider}!"
      sign_in(authentication.user)
      redirect_to dashboard_path
    
    # Otherwise, if the user is signed in, create the authentication.
    elsif current_user
      current_user.authentication.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful!"
      redirect_to authentications_url
    
    # If this is a new user, redirect them to sign in
    # I want users to be required to have an account with my app before setting up authentications
    # with other sites (Twitter, Facebook, etc.)
    else
      flash[:notice] = "You must be signed in to access this page."
      redirect_to signin_path
    end
      
    # Using find_or_create_by_provider_and_uid it prevents duplicate records in the
    # authentications database should a user try to authenticate with the same service and info.
    # Assumes the user is already signed in to my app
    # 
    # current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    # flash[:notice] = "Authentication successful!"
    # redirect_to authentications_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

end
