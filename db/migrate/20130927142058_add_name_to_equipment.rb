class AddNameToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :name, :string
  end
end
