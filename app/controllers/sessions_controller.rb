class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user) if logged_in?
  end

  def create
    user = User.find_by(username: login_params[:username])

    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You were logged in successfully.'
      redirect_to root_path
    else
      flash.now[:error] = 'Username/password combination do not match.'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'You were logged out successfully.'
    redirect_to posts_path
  end

  private
  def login_params
    params.permit(:username, :password)
  end
end
