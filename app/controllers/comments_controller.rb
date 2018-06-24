class CommentsController < ApplicationController
  def create
    @post    = Post.find params[:post_id]
    @comment = Comment.new(params.require(:comment).permit(:body).merge(post: @post))
    if @comment.save
      flash[:notice] = 'Comment has been created'
      redirect_to post_path(@post.id)
    else
      render 'posts/show'
    end
  end
end
