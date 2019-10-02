class Admin::AdminController < ApplicationController
  def check_admin
    return if current_user.admin?
    flash[:danger] = t "errors_message.access_denied"
    redirect_to root_path
  end

  def check_admin_supervisor
    return if current_user.admin? || current_user.supervisor?
    flash[:danger] = t "errors_message.access_denied"
    redirect_to root_path
  end
end
