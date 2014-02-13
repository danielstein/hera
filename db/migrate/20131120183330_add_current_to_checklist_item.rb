class AddCurrentToChecklistItem < ActiveRecord::Migration
  def up
  	add_column :checklist_items, :current, :boolean
  end

  def down
  	remove_column :checklist_items, :current
  end
end
