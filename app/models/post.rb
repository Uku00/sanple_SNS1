class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  accepts_nested_attributes_for :tags

  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :title, length: { maximum: 100 }
  validates :body, length: { maximum: 1000 }

  validate :must_have_at_least_one_photo

  private

  def must_have_at_least_one_photo
    if photos.blank? || photos.all? { |p| !p.image.attached? }
      errors.add(:base, "少なくとも1枚の画像が必要です")
    end
  end
end
