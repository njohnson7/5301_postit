class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= session && session[:user_id] && User.find_by(slug: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def admin?
    logged_in? && current_user.role == 'admin'
  end

  private

  def require_user
    unless logged_in?
      flash[:error] = 'You must be logged in to do that'
      redirect_to root_path
    end
  end

  def require_admin
    unless admin?
      flash[:error] = 'You must be an admin to do that'
      redirect_to root_path
    end
  end
end
