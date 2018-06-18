class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :orders
  has_many :ratings
  has_many :products, through: :ratings
  has_many :comments
  has_many :suggests
end
