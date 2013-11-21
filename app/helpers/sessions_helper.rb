module SessionsHelper

  def sign_in(user)
    
    # Create token
    remember_token = User.new_remember_token
    
    # Place token in cookies
    cookies.permanent[:remember_token] = remember_token
    
    # Save encryped token to DB
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    
    # Set current user to given user if necessary
    self.current_user = user
  end


  ### Code to implement friendly forwarding:
  def redirect_back_or(default)
    redirect_to( session[:return_to] || default )
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
  #########


  def signed_in?
    !current_user.nil?  
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end


end
