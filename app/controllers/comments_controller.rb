class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])

    if @comment.save
      @post.comments << @comment
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
