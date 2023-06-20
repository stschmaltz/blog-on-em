class CreatePostTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :post_taggings do |t|
      t.references :post, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
