class RemoveIdPlaceFromInspections < ActiveRecord::Migration
 def self.up
  remove_column :inspections, :id_place
 end
 def self.down
  add_column :inspections, :id_place, :string 
 end
end
