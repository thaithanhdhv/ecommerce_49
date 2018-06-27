class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details

  enum status: %i{cancelled in_progress rejected approved}
end
