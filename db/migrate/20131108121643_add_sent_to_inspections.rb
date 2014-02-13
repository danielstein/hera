class AddSentToInspections < ActiveRecord::Migration
  def up
  	add_column :inspections, :sent, :integer
  end

  def down
  	remove_column :inspections, :sent
  end
end
