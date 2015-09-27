class AddTimeUntilDeletionToImages < ActiveRecord::Migration
  def change
    add_column :images, :time_until_deletion, :float
  end
end