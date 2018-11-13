class Admin::BaseController < ActionController::Base
  layout "admin/application"
  before_action :logged_in_user
  before_action :admin_user
  include SessionsHelper

  private

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Vui lòng đăng nhập"
      redirect_to login_url
    end
  end
end
