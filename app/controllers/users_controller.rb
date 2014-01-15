class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

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

  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your account has been updated.'
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end

  def show
    @tab  = params[:tab].nil? ? 'posts' : 'comments'
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    unless @user == current_user
      flash[:error] = 'You do not have access to that.'
      redirect_to root_path
    end
  end
end
