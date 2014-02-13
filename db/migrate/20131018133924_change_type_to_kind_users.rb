class ChangeTypeToKindUsers < ActiveRecord::Migration
  def up
    rename_column :users, :type, :kind
  end

  def down
    rename_column :users, :kind, :type
  end

end
