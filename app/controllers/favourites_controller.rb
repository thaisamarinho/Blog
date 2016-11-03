class FavouritesController < ApplicationController
  def create
    post = Post.find params[:post_id]
    favourite = Favourite.new(user: current_user, post: post)
    if cannot? :favourite, post
      redirect_to :back, notice: '🙅🏻 Access denied!'
    elsif favourite.save
      redirect_to post_path(post), notice: 'Thanks for Favouriting! 😇'
    else
      redirect_to post_path(post), alert: favourite.errors.full_messages.join(", ")
    end
  end

  def destroy
    favourite = Favourite.find params[:id]
    if favourite.destroy
      redirect_to :back, notice: '😡'
    else
      redirect_to :back, alert: favourite.errors.full_messages.join(", ")
    end
  end

  def index
      @favourites = Favourite.where(user_id: current_user)
  end

end
