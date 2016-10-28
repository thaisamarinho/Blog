class PasswordsController < ApplicationController

  def new
    email = params[:email]
    if email.present?
      render :forgot_password
    else
      render :new
    end
  end

  def index
  end

  def edit
    @password = params.dig(:user, :password)
    @user = current_user
  end

  def update
    @user = User.find current_user
    current_password = params.dig(:user, :current_password)
    if @user && @user.authenticate(current_password)
      if @user.update user_params
        redirect_to home_path, notice: 'Changes made'
      else
        flash.now[:alert] = 'Failed to update your info'
        render :edit
      end
    else
      flash.now[:alert] = 'Wrong Password'
      render :edit
    end
  end

  def link
    @user = User.find_by(email: params[:email])
    if @user
      @user.update!(token: rand(100))
    else
      redirect_to home_path, alert: 'Buuuuuuuuuuu'
    end
  end

  def forgot_password
    @user = User.find_by(email: params[:email], token: params[:token])
    if @user
      render
    else
      redirect_to home_path, alert: 'Buuuuuuuuuuu'
    end
  end

  def update_password
    @email = params.dig(:user, :email)
    @user = User.find_by(email: @email)
    if @user.update user_params
      redirect_to home_path, notice: 'Password changed'
    else
      flash.now[:alert] = 'Failed to update your info'
      render :forgot_password
    end
  end

  def user_params
    user_params = params.require(:user).permit([
                                              :password,
                                              :password_confirmation])
  end
end
