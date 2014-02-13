class AddApprovedToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :approved, :boolean
  end
end
