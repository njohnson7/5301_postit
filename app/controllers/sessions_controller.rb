class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by username: params[:username]

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
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