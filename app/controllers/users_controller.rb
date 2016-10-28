class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "Thanks for signing up!"
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find current_user
    current_password = params.dig(:user, :password)
    if @user && @user.authenticate(current_password)
      if @user.update user_params
        redirect_to home_path, notice: 'Changes made'
      else
        flash.now[:alert] = 'Wrong Credentials'
        render :edit
      end
    else
      flash.now[:alert] = 'Wrong Credentials'
      render :edit
    end
  end

  def user_params
  user_params = params.require(:user).permit([:first_name,
                                              :last_name,
                                              :email,
                                              :password,
                                              :password_confirmation])
  end

end
