class AddIdPlaceToEquipment < ActiveRecord::Migration
  def up
  	add_column :equipment, :id_place, :string
  end

  def down
  	remove_column :equipment, :id_place
  end
end
