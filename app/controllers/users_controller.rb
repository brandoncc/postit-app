class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user_or_admin, only: [:edit, :update]

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
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def show
    @tab  = params[:tab].nil? ? 'posts' : 'comments'
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :time_zone, :phone)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def require_same_user_or_admin
    access_denied unless @user == current_user || admin?
  end
end
