class AddPhotoToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :photo_url, :string
  end
end
