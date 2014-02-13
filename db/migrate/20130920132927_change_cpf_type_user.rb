class ChangeCpfTypeUser < ActiveRecord::Migration
  def self.up
   change_column :users, :cpf, :string
  end

  def self.down
   change_column :users, :cpf, :integer
  end
end
