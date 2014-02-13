class ChangeIsOkTypeAnswers < ActiveRecord::Migration
  def self.up
   change_column :answers, :is_ok, :integer
  end

  def self.down
   change_column :answers, :is_ok, :boolean
  end
end
