class ChangeExistToIsThereEquipment < ActiveRecord::Migration
  def up
    rename_column :equipment, :exists, :is_there
  end
  
  def down
    rename_column :equipment, :is_there, :exists
  end

end
