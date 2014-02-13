class AddFloorToInspections < ActiveRecord::Migration
  def up
  	add_column :inspections, :floor, :integer
  end

  def down
  	remove_column :inspections, :floor
  end	
end
