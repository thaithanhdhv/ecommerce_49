module Admin
  class OrderDetailsController < AdminController
    before_action :load_order, only: :index

    def index
      @order_details = OrderDetail.by_order_id(params[:order_id])
        .paginate page: params[:page], per_page: Settings.product_per_page
    end

    private

    def load_order
      @order = Order.find_by id: params[:order_id]
      valid_object @order
    end
  end
end
