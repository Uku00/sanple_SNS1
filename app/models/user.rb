class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :avatar_image
  has_one_attached :cover_image

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 300 }
  validate  :avatar_image_format
  validate  :cover_image_format
  #validates :name, presence: true


  private

  def avatar_image_format
    return unless avatar_image.attached?
    unless avatar_image.content_type.in?(%w(image/jpeg image/png))
      errors.add(:avatar_image, "はJPEGまたはPNG形式のみアップロードできます")
    end
  end

  def cover_image_format
    return unless cover_image.attached?
    unless cover_image.content_type.in?(%w(image/jpeg image/png))
      errors.add(:cover_image, "はJPEGまたはPNG形式のみアップロードできます")
    end
  end
end
