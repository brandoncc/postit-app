class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new if @comment.nil?
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = @user

    if @post.save
      flash[:notice] = 'Your post was created successfully.'
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Your post was updated successfully.'
      redirect_to(post_path(@post))
    else
      render :edit
    end
  end

  private
  def set_selected_categories
    selected_categories = params[:post][:categories]
    if selected_categories.nil?
      @post.category_ids = []
    else
      @post.category_ids = params[:post][:categories].map { |c| c.to_i }
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_all_categories
    @categories = Category.all
  end

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
end
