class AddScheduledDeletionDateToImages < ActiveRecord::Migration
  def change
    add_column :images, :scheduled_deletion_date, :datetime
  end
end
