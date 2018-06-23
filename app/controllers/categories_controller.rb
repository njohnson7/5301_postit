class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find params[:id]
    @posts    = Post.select { |post| post.categories.include?(@category) }
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new params.require(:category).permit(:name)
    if @category.save
      flash[:notice] = 'Category has been created'
      redirect_to posts_path
    else
      render :new
    end
  end
end
