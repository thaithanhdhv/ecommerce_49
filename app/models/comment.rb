class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true, length: {maximum: Settings.comment.max_length}

  delegate :name, to: :user, prefix: :user
end
