class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post            = Post.find_by params[:post_id]
    # @post            = Post.find_by slug: params[:post_id]
    @comment         = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find params[:id]
    v = Vote.new(vote: params[:vote], creator: current_user, voteable: comment)
    if v.save
      flash[:notice] = 'Your vote has been counted'
    else
      flash[:error] = 'Sorry, you can only vote once per item'
    end

    redirect_to :back
  end
end
