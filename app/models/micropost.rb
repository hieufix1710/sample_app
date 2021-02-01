class Micropost < ApplicationRecord
  belongs_to :user
  scope :by_created_at, -> { order(created_at: :desc) }
  has_one_attached :image
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
    message: "must_be_a_valid_image_format" },
    size: { less_than: 5.megabytes, message: "should_be_less_than_5MB" }

  def display_image
    image.variant resize_to_limit: [500, 500]
  end


  end
