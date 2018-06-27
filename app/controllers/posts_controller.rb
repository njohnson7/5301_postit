class PostsController < ApplicationController
  before_action :set_post,                   only:   [:show, :edit, :update, :vote]
  before_action :require_user,               except: [:index, :show]
  before_action :require_admin_or_same_user, only:   [:edit, :update]

  def index
    # @posts = Post.all.sort_by { |post| -post.total_votes }
    @posts = Post.limit(Post::PER_PAGE).offset(params[:offset])
    @pages = Post.all.size.fdiv(Post::PER_PAGE).ceil

    respond_to do |format|
      format.html
      format.json { render json: @posts }
      format.xml  { render xml: @posts }
    end
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
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @post)

    respond_to do |format|
      format.html do
        if v.valid?
          flash[:notice] = 'Your vote has been counted'
        else
          flash[:error]  = 'Sorry, you can only vote once per item'
        end
        redirect_to :back
      end

      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by slug: params[:id]
  end

  def require_admin_or_same_user
    super(@post.creator)
  end
end
