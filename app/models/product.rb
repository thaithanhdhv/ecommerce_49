class Product < ApplicationRecord
  belongs_to :category
  has_many :oder_details
  has_many :orders, through: :oder_details
  has_many :ratings
  has_many :comments
  has_many :cart_items

  mount_uploader :image, PictureUploader
  validates :title, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :description, presence: true, length: {maximum: Settings.description_max}
  validate  :picture_size

  scope :starts_with, ->(name){where "title like ?", "#{name}%"}
  scope :order_price, ->{order(price: :desc)}

  def check_quantity?
    self.quantity = 0
  end

  private

  def picture_size
    return unless image.size > Settings.max_image_size.megabytes
    errors.add :image, I18n.t("image_size")
  end
end
