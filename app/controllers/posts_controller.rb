class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
     if @post.save
       redirect_to post_path(@post)
     else
       render :new
     end
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
    if @post.category_id != nil
      @category = Category.find @post.category_id
    end
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    post_params = params.require(:post).permit([:title, :body, :category_id, :star_count, tag_ids: []])
  end
end
