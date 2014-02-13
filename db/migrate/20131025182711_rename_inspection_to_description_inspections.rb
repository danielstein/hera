class RenameInspectionToDescriptionInspections < ActiveRecord::Migration
  def up
    rename_column :inspections, :inspection, :description
  end
  
  def down
    rename_column :inspections, :description, :inspection
  end
end
