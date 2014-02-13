class ChangeApprovedTypeInspections < ActiveRecord::Migration
  def self.up
   change_column :inspections, :approved, :integer
  end

  def self.down
   change_column :inspections, :approved, :boolean
  end
end
