class StarsController < ApplicationController
  before_action :authenticate_user
  def create
    star = Star.new star_params
    star.user = current_user
    star.post = post

    if star.save
      redirect_to post_path(post), notice: 'Thanks for your rating!'
    else
      redirect_to post_path(post), alert: star.errors.full_messages.join(", ")
    end
  end

  def destroy
    post = star.post
    star.destroy
    redirect_to post_path(post)
  end

  def  update
    post = star.post
    if star.update star_params
      redirect_to post_path(post)
    else
      redirect_to post_path(post), alert: star.errors.full_messages.join(", ")
    end
  end

private

  def star_params
    params.require(:star).permit(:count)
  end

  def post
    @post ||= Post.find params[:post_id]
  end

  def star
    @star ||= Star.find params[:id]
  end
end
