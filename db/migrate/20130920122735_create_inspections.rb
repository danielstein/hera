class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
