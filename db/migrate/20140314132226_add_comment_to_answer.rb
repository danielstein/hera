class AddCommentToAnswer < ActiveRecord::Migration
  def self.up
    add_column :answers, :comment, :string
  end

  def self.down
    remove_column :answers, :comment, :string
  end
end
