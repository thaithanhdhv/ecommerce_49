class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details

  enum status: %i(in_progress cancelled rejected approved)
  validates :name, :phone, :address, presence: true

  delegate :name, to: :user, prefix: :user

  scope :status, ->(status){where status: status if status}
  scope :newest, ->{order(created_at: :desc)}
end
