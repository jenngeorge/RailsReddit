class SessionsController < ApplicationController

  def new
  end

  def create
    user_name = login_params[:user_name]
    password = login_params[:password]

    @user = User.find_by_credentials(user_name, password)
    if @user
      login_user!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    logout!
    redirect_to root_url
  end

  private

  def login_params
    params.require(:user).permit(:user_name, :password)
  end
end
