module SessionsHelper

  def sign_in(user)
    # Generate a secure remember token based on user's salt and id.
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def deny_access
    hold_location
    redirect_to signin_path, :notice => "You must be logged in to access this page."
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_hold
  end

  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def current_user?(user)
    user == current_user
  end
  
  
    
private
  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end
  
  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
  
  # Stores the url of the page user is attempting to view within a session variable
  def hold_location
    session[:return_to] = request.fullpath
  end
  
  def clear_hold
    session[:return_to] = nil
  end

end
