class AddColumnExistsToEquipment < ActiveRecord::Migration
  def up
  	add_column :equipment, :exists, :boolean
  end
  def down
  	remove_column :equipment, :exists
  end	
end
