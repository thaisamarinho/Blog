class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_post, except:[:index,:new,:create]

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
    @comment = Comment.new
    if @post.category_id != nil
      @category = Category.find @post.category_id
    end

    respond_to do |format|
      format.html { render }
      format.text { render }
      format.xml { render xml: @post }
      format.json { render json: @post.to_json(include: :comments) }
    end

  end

  def index
    @posts = Post.order(created_at: :desc)
    respond_to do |format|
      format.html { render }
      format.text { render }
      format.xml { render xml: @posts }
      format.json { render json: @posts.to_json }
    end
  end

  def edit

  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end


  private
  def post_params
    post_params = params.require(:post).permit([:title, :body, :category_id, :star_count, tag_ids: []])
  end

  def find_post
    @post=Post.find params[:id]
  end
end
