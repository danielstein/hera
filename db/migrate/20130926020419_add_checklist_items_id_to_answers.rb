class AddChecklistItemsIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :checklist_item_id, :integer
  end
end
