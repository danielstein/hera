class RemoveDateFromInspections < ActiveRecord::Migration
 def self.up
  remove_column :inspections, :date
  end
  def self.down
  add_column :inspections, :date
  end
end
