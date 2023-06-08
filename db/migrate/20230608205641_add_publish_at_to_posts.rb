# frozen_string_literal: true

# adds a publish_at column to the posts table
class AddPublishAtToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :published_at, :datetime
    remove_column :posts, :published, :boolean
  end
end
