class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.references :post, null: false, foreign_key: true
      t.text :description
      t.string :text_color
      t.string :text_position

      t.timestamps
    end
  end
end
