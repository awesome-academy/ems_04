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
end
