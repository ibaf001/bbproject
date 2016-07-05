module SessionsHelper


  def log_in(user)
    session[:user_id] = user.id
  end

  #return current user logged in
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #return true if user is logged in
  def logged_in?
    !current_user.nil?
  end
end
