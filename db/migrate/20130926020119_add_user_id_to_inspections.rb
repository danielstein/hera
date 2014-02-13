class AddUserIdToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :user_id, :integer
  end
end
