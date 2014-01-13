class SessionsController < ApplicationController
  def new
    if @current_user.nil?
      render template: 'sessions/new', locals: { username: '' }
    else
      redirect_to user_path(user)
    end
  end

  def create
    @user = User.find_by(username: login_params[:username])

    if !@user.nil? && @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      flash[:error] = 'Username/password combination do not match.'
      render template: 'sessions/new', locals: { username: login_params[:username] }
    end
  end

  def destroy
    reset_session
    redirect_to posts_path
  end

  private
  def login_params
    params.require('login').permit(:username, :password)
  end
end
