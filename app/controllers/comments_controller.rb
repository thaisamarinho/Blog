class CommentsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def new
    @comment = comment.new
  end

  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
     if @comment.save
       redirect_to post_path(@post)
     else
       render 'posts/show'
     end
  end

  def show
    @comment = comment.find params[:id]
  end

  def index
    @comments = comment.order(created_at: :desc)
  end

  def edit
    @comment = comment.find params[:id]
  end

  def update
    @comment = comment.find params[:id]
    comment_params = params.require(:comment).permit(:body)
    if @comment.update comment_params
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find params[:post_id]
    comment = Comment.find params[:id]
    comment.destroy
    redirect_to post_path(post)
  end

  def comment_params
    comment_params = params.require(:comment).permit([:body])
  end

end
