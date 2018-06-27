class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin?, :same_user?

  def current_user
    @current_user ||= session && session[:user_id] && User.find_by(slug: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def admin?
    logged_in? && current_user.admin?
  end

  def same_user?(user = @user)
    logged_in? && current_user == user
  end

  private

  def access_denied(msg = "You're not allowed to do that.")
    flash[:error] = msg
    redirect_to root_path
  end

  def require_user
    access_denied('You must be logged in to do that.') unless logged_in?
  end

  def require_admin
    access_denied unless admin?
  end

  def require_same_user(user = @user)
    access_denied unless same_user?(user)
  end

  def require_admin_or_same_user(user = @user)
    access_denied unless admin? || same_user?(user)
  end
end
