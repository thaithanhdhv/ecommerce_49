class ProductsController < ApplicationController
  before_action :load_product, only: %i(show)

  def index
    @products = Product.order_price.paginate page: params[:page], per_page: Settings.product_per_page
    @cart_item = current_cart.cart_items.new
  end

  def show; end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:warning] = t ".oproduct_nil"
    redirect_to root_path
  end
end
