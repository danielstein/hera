class RemoveFloorFromInspections < ActiveRecord::Migration
 def self.up
  remove_column :inspections, :floor
 end
 def self.down
  add_column :inspections, :floor, :id_place
 end
end
