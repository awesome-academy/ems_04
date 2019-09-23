class UsersController < ApplicationController
  layout "no_sidebar"

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "signup_page.register_success"
      redirect_to login_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
          .permit :last_name, :first_name, :email, :password, :bio, :photo
  end
end
