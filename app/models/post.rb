class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  serialize :tags, Array
  validates :title, presence: true

  def self.published
    where('published_at < ? AND published_at IS NOT NULL', timestamp)
      .order(published_at: :desc)
  end

  def self.unpublished
    where('published_at IS NULL OR published_at > ?', timestamp)
      .order('CASE WHEN published_at IS NULL THEN 0 ELSE 1 END, published_at DESC')
  end

  def self.timestamp
    Time.now
  end

  def comment_count
    comments.count
  end
end
