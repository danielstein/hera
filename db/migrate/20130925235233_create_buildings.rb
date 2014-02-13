class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.integer :idAtlas
      t.string :name

      t.timestamps
    end
  end
end
