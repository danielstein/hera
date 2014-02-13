class AddEquipTypeIdToChecklistItems < ActiveRecord::Migration
  def change
    add_column :checklist_items, :equip_type_id, :integer
  end
end
