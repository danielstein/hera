class AddBuildingIdToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :building_id, :integer
  end
end
