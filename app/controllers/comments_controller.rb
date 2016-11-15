class CommentsController < ApplicationController
  # before_action :authenticate_user, except: [:index, :show]
  skip_before_action :verify_authenticity_token

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
    respond_to do |format|
     if @comment.save
      #  byebug
       format.text {render}
       format.xml {render xml: @post}
       format.js {render :create_success}
       format.html {redirect_to post_path(@post)}
     else
       format.text {render}
       format.xml {render xml: @post}
       format.js {render :create_failure}
       format.html {render 'posts/show'}
     end
   end
  end

  def show
    @comment = Comment.find params[:id]
  end

  def index
    @comments = Comment.order(created_at: :desc)
    # respond_to do |format|
    #   format.js { render  }
    # end
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def update
    @comment = Comment.find params[:id]
    comment_params = params.require(:comment).permit(:body)
    if @comment.update comment_params
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    respond_to do |format|
      if @comment.destroy
        format.js {render :destroy}
        format.html {redirect_to post_path(@post)}
      else
        format.js {render js: 'alert("Access Denied!!!!")'}
        format.html {redirect_to root_path, alert: 'Access Denied!'}
      end
    end
  end

  def comment_params
    comment_params = params.require(:comment).permit([:body])
  end

end
