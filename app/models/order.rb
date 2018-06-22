class Order < ApplicationRecord
  belongs_to :user
  has_many :oder_details
  has_many :products, through: :oder_details

  before_validation :set_oder_status

  enum status: {process: 0, placed: 1, shipped: 2}

  private

  def set_oder_status
    self.status = "process"
  end
end
