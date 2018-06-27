class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]

  def new
  end

  def create
    @user = User.find_by username: params[:username]

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.slug
      flash[:notice]    = 'You have logged in.'
      redirect_to root_path
    else
      flash[:error] = 'Problem with username or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice]    = 'You have logged out.'
    redirect_to root_path
  end
end