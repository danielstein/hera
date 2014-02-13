class CreateAttributeValues < ActiveRecord::Migration
  def change
    create_table :attribute_values do |t|
      t.string :value
      t.datetime :date

      t.timestamps
    end
  end
end
