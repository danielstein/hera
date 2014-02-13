class AddColumnCreationDateToEquipment < ActiveRecord::Migration
  def up
  	add_column :equipment, :creation_date, :datetime
  end
  def down
  	remove_column :equipment, :creation_date
  end
end
