class OderDetailsController < ApplicationController
  def index
    @order_details = @order.oder_details
  end
end
