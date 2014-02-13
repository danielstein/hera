class ChangeIdAtlasTypeBuilding < ActiveRecord::Migration
  def up
    change_column :buildings, :idAtlas, :string
  end

  def down
    change_column :buildings, :idAtlas, :integer
  end
end
