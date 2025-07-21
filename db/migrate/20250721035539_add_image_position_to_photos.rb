class AddImagePositionToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :image_position, :string
  end
end
