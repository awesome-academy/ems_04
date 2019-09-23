class SessionsController < ApplicationController
  layout "no_sidebar"

  def new; end

  def create
    user = User.find_by email: sess_params[:email].downcase
    if user&.authenticate(sess_params[:password])
      log_in user
      remember_me user
      redirect_back_or root_path
    else
      flash.now[:danger] = t "login_page.valid_account"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def sess_params
    params.require(:session).permit :email, :password, :remember_me
  end

  def remember_me user
    remember_val = Settings.remember_me
    sess_params[:remember_me] == remember_val ? remember(user) : forget(user)
  end
end
