class AddInspectionIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :inspection_id, :integer
  end
end
