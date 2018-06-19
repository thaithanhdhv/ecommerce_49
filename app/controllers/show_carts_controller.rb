class ShowCartsController < ApplicationController
  def show
    @cart_items = current_cart.cart_items.sort
  end
end
