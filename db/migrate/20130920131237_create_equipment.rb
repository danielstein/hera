class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :id_atlas

      t.timestamps
    end
  end
end
