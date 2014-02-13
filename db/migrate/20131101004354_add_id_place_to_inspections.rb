class AddIdPlaceToInspections < ActiveRecord::Migration
  def up
  	add_column :inspections, :id_place, :string
  end

  def down
  	remove_column :inspections, :id_place
  end	
end
