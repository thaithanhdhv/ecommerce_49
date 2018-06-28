module OrdersHelper
  def create_ordersdetails cart, order
    producs_of_current_cart = Product.load_product_by_ids cart.keys
    producs_of_current_cart.each do |product|
      product.quantity_in_cart = cart[product.id.to_s]
      unit_price = (product.price).to_i
      total_price = product.quantity_in_cart * unit_price
      order_detail = order.order_details.new(order_id: order.id,
        product_id: product.id, quantity: product.quantity_in_cart,
        unit_price: unit_price, total_price: total_price)
      order_detail.save
    end
  end
end
