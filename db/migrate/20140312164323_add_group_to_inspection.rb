class AddGroupToInspection < ActiveRecord::Migration
  def self.up
    add_column :inspections, :group_id, :integer
    Inspection.update_all 'group_id = 0'
  end

  def self.down
    remove_column :inspections, :group_id
  end
end
