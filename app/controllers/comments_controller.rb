class CommentsController < ApplicationController
  def create
    binding.pry

    @post    = Post.find params[:post_id]
    # @comment = Comment.new(params.require(:comment).permit(:body))
    @comment = @post.comments.build(params.require(:comment).permit(:body))

    if @comments.save
      flash[:notice] = 'Your comment was added'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end
