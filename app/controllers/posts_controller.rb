class PostsController < ApplicationController
  before_action :set_post,     only:   [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all.sort_by { |post| -post.total_votes }
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post         = Post.new post_params
    @post.creator = current_user

    if @post.save
      flash[:notice] = 'Post successfully created'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update post_params
      flash[:notice] = 'Post has been updated'
      redirect_to posts_path
    else
      render :edit
    end
  end

  def vote
    v = Vote.new(vote: params[:vote], creator: current_user, voteable: @post)
    if v.save
      flash[:notice] = 'Your vote has been counted'
    else
      flash[:error] = 'There was a problem with your vote'
    end

    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find params[:id]
  end
end
