class CommentsController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])
    vote  = current_user.votes.build(voteable: comment, value: params[:upvote] == 'true' ? 1 : -1)

    if vote.save
      flash[:notice] = 'Your vote has been recorded.'
    else
      flash[:error] = 'You have already voted on this comment.'
    end

    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
