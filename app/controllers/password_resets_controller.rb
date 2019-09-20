class PasswordResetsController < ApplicationController
  layout "no_sidebar"

  before_action :load_user, :valid_user,
    :check_expiration, only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "forgot_page.sent_link"
      redirect_to root_url
    else
      flash.now[:danger] = t "forgot_page.invalid_email"
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      @user.errors.add(:password, t("forgot_page.blank_pass"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t "forgot_page.done_reset"
      redirect_to root_path
    else
      render :edit
    end
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t "forgot_page.invalid_email"
    redirect_to root_path
  end

  def valid_user
    return if @user.authenticated?(:reset, params[:id])
    redirect_to help_path
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "forgot_password.expired_time"
    redirect_to new_password_reset_url
  end
end
