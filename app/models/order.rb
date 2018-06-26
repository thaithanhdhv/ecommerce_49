class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details

  enum status: %i{in_progress cancelled rejected approved}

  delegate :name, to: :user, prefix: :user

  scope :status, ->(status){where status: status if status}
end
