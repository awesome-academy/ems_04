class StaticPagesController < ApplicationController
  def home
    return if logged_in?
    flash[:danger] = t "login_page.require_login"
    redirect_to login_path
  end

  def help; end
end
