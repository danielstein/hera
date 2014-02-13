class ChangeBuildingIdEquipment < ActiveRecord::Migration
  def up
    change_column :equipment, :building_id, :string
  end

  def down
    change_column :equipment, :building_id, :integer
  end
end
