class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    post = Post.find params[:post_id]
    like = Like.new(user: current_user, post: post)
    if cannot? :like, post
      redirect_to :back, notice: '🙅🏻 Access denied!'
    elsif like.save
      redirect_to post_path(post), notice: 'Thanks for Liking! 😇'
    else
      redirect_to post_path(post), alert: like.errors.full_messages.join(", ")
    end
  end

  def destroy
    like = Like.find params[:id]
    if like.destroy
      redirect_to :back, notice: '😡'
    else
      redirect_to :back, alert: like.errors.full_messages.join(", ")
    end
  end

  def index
    @likes = Like.order(created_at: :desc)
  end

end
