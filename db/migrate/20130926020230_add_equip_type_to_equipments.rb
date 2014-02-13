class AddEquipTypeToEquipments < ActiveRecord::Migration
  def change
    add_column :equipment, :equip_type_id, :integer
  end
end
