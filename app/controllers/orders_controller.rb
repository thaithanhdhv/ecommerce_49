class OrdersController < ApplicationController
  def show
    if logged_in? && current_user.present?
      @orders = current_user.orders
    else
      flash.now[:danger] = t "login_notice"
    end
  end
end
