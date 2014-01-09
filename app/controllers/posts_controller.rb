class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_path(@post.id)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @post.update_attributes(post_params)
    @post.save

    render :show
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params[:post].permit(:title, :url, :description)
  end
end
