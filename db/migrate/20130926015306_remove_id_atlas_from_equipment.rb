class RemoveIdAtlasFromEquipment < ActiveRecord::Migration
  def self.up
  remove_column :equipment, :id_atlas
  end
  def self.down
  add_column :equipment, :id_atlas
  end
end
