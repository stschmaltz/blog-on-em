class AssociateUsersToComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :name, :string
    add_column :comments, :user_id, :integer
    Comment.delete_all
  end
end
