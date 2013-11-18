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
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end


end
