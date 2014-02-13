class AddEquipmentIdToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :equipment_id, :integer
  end
end
