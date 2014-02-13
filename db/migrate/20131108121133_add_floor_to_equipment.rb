class AddFloorToEquipment < ActiveRecord::Migration
  def up
  	add_column :equipment, :floor, :integer
  end

  def down
  	remove_column :equipment, :floor
  end	
end
