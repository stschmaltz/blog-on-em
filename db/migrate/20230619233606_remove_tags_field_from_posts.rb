class RemoveTagsFieldFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :tags, :text
  end
end
