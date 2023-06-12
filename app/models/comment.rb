class Comment < ApplicationRecord
  belongs_to :post

  validates :name, :content, presence: true
end
