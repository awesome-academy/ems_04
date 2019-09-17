class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "login_page.require_login"
    redirect_to login_url(returnUrl: session[:forwarding_url])
  end

  def check_admin
    return if current_user.admin?
    flash[:danger] = t "errors_message.access_denied"
    redirect_to root_path
  end
end
