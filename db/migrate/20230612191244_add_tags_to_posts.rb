class AddTagsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :tags, :text
  end
end
