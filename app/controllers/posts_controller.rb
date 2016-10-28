class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_post, except: [:index, :create, :new]
  before_action :authorize_access, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
     if @post.save
       flash[:notice] = "Post was created successfully"
       redirect_to post_path(@post)
     else
       flash[:alert] = "Post was not created. Please see errors below"
       render :new
     end
  end

  def show
    @comment = Comment.new
    @like = @post.like_for(current_user)
    if @post.category_id != nil
      @category = Category.find @post.category_id
    end
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      flash[:alert] = "Post was not updated. Please see errors below"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post Deleted'
  end

  def post_params
    post_params = params.require(:post).permit([:title, :body, :category_id])
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize_access
    unless can? :manage, @post
      # unless (current_user == @question.user || current_user.admin?)
      # head :unauthorized # this will send a 401 response
      redirect_to home_path, alert: 'Access Denied'
    end
  end

end
