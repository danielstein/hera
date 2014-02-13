class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :nusp
      t.integer :cpf
      t.string :name
      t.string :password

      t.timestamps
    end
  end
end
