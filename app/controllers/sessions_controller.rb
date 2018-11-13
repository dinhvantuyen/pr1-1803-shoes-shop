class SessionsController < ApplicationController
  before_action :login_user, only: :new
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      if current_user.admin?
        redirect_to admin_root_path
      else
        redirect_back_or root_path
      end
    else
      flash.now[:danger] = "Đăng nhập sai vui lòng kiểm tra lại"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

end
