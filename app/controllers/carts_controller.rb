class CartsController < ApplicationController
  def show
    @oder_details = current_order.oder_details.sort
  end
end
