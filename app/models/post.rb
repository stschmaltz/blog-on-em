class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :user_likes, through: :post_likes, source: :user

  has_many :post_taggings, dependent: :destroy
  has_many :tags, through: :post_taggings

  validates :title, presence: true

  scope :decending, -> { order(created_at: :desc) }

  scope :published, lambda {
    where('published_at < ? AND published_at IS NOT NULL', timestamp)
      .decending
  }
  scope :unpublished, lambda {
    where('published_at IS NULL OR published_at > ?', timestamp)
      .order('CASE WHEN published_at IS NULL THEN 0 ELSE 1 END, published_at DESC')
  }

  scope :with_tag, lambda { |tag_id|
    joins(:post_taggings).where(post_taggings: { tag_id: tag_id })
  }

  def self.timestamp
    Time.now
  end

  def comment_count
    comments.count
  end
end
