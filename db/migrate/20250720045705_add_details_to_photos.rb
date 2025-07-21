class AddDetailsToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :text_align, :string
  end
end
