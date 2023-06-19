class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :liked_posts, through: :post_likes, source: :post

  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
end
