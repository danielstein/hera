class CreateEquipTypes < ActiveRecord::Migration
  def change
    create_table :equip_types do |t|
      t.string :type

      t.timestamps
    end
  end
end
