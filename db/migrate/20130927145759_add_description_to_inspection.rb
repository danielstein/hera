class AddDescriptionToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :inspection, :string
  end
end
