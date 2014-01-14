class UsersController < ApplicationController
  before_action :require_login, except: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Your account has been created.'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'Your account has been updated.'
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @tab  = params[:tab].nil? ? 'posts' : 'comments'
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
