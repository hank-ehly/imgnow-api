class RemoveUsernameFromUser < ActiveRecord::Migration
  def change
    remove_index :users, :username
    remove_column :users, :username, :string
  end
end
