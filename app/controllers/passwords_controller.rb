class PasswordsController < ApplicationController

  def new
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

  def user_params
    user_params = params.require(:user).permit([
                                              :password,
                                              :password_confirmation])
  end
end
