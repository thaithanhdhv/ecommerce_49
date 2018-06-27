module CartsHelper
  def set_cart
    session[:cart] ||= {}
  end

  def sum_total_price_of_cart
    @producs_of_current_cart.collect{|product| product.quantity_in_cart * product.price}.sum
  end

  def is_empty_cart?
    session[:cart].blank?
  end
end
