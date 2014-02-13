class ChangeTypesToKindEquipTypes < ActiveRecord::Migration
  def up
    rename_column :equip_types, :type, :kind
  end

  def down
    rename_column :equip_types, :kind, :type
  end

end
