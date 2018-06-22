class OderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: {only_integer: true, greater_than: Settings.min_size}
  validate :product_present
  validate :order_present

  private

  def product_present
    errors.add(:product, t("error_message")) if product.nil?
  end

  def order_present
    errors.add(:order, t("error_message")) if order.nil?
  end
end
