module Admin
  class OrderDetailsController < ApplicationController
    def index
      @order_details = OrderDetail.by_order_id(params[:order_id])
        .paginate page: params[:page], per_page: Settings.product_per_page
    end
  end
end
