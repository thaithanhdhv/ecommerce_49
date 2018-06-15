class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      check_admin user
      redirect_to user
    else
      flash.now[:danger] = t "sessions.fail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def check_admin user
    if user.admin?
      redirect_to admin_root_path
    else
      redirect_to root_path
    end
  end
end
