class AddAnswerIdToUpload < ActiveRecord::Migration
  def self.up
    add_column :uploads, :answer_id, :integer
  end

  def self.down
    remove_column :uploads, :answer_id
  end
end
