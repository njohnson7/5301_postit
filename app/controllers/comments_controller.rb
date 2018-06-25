class CommentsController < ApplicationController
  def create
    @post            = Post.find params[:post_id]
    @comment         = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = User.first  # TODO: fix after authentication

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end
