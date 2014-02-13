class CreateAttributeInspections < ActiveRecord::Migration
  def change
    create_table :attribute_inspections do |t|
      t.boolean :is_ok

      t.timestamps
    end
  end
end
