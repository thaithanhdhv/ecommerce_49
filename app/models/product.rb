class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_many :orders, through: :order_details
  has_many :ratings
  has_many :comments

  scope :starts_with, ->(name){where "title like ?", "#{name}%"}
end
