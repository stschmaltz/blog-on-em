class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :post_taggings, dependent: :destroy
  has_many :posts, through: :post_taggings
end
