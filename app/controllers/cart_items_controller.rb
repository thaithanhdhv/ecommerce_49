class CartItemsController < ApplicationController
  before_action :load_order, only: %i(update destroy)

  def create
    @cart = current_cart
    @cart_item = @cart.cart_items.new order_item_params
    if @cart.save
     session[:cart_id] = @cart.id
    else
      flash.now[:danger] = t "error_message"
    end
  end

  def update
    if @cart_item.update_attributes order_item_params
      @cart_items = @cart.cart_items
    else
      flash.now[:danger] = t "error_message"
    end
  end

  def destroy
    if @cart_item.destroy
      @cart_items = @cart.cart_items
    else
      flash.now[:danger] = t "error_message"
    end
  end

  private

  def order_item_params
    params.require(:cart_item).permit :quantity, :product_id
  end

  def load_order
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by id: params[:id]
    redirect_to products_path unless @cart_item
  end
end
