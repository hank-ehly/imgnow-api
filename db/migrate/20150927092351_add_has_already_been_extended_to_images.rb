class AddHasAlreadyBeenExtendedToImages < ActiveRecord::Migration
  def change
    add_column :images, :has_already_been_extended, :boolean
  end
end
