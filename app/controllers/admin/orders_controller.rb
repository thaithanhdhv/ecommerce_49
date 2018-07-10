module Admin
  class OrdersController < AdminController
    load_and_authorize_resource

    def index
      @orders = Order.status(params[:status])
        .paginate page: params[:page], per_page: Settings.product_per_page
    end

    def update
      ActiveRecord::Base.transaction do
        begin
          if @order.send("#{params[:order][:status]}!")
            flash[:danger] = t "sucess_msg"
            redirect_to admin_orders_path
          end
        rescue
          flash[:danger] = t "error_message"
          render :index
        end
      end
    end
  end
end
