class ChangeIdAtlasTypeEquipment < ActiveRecord::Migration
  def self.up
   change_column :equipment, :id_atlas, :integer
  end

  def self.down
   change_column :equipment, :id_atlas, :string
  end
end
