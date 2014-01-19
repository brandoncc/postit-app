class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :admin?

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    redirect_to login_path unless logged_in?
  end

  def admin?
    logged_in? && current_user.role == 'admin'
  end

  def access_denied
    flash[:error] = 'You do not have access to that.'
    redirect_to root_path
  end
end
