class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.text :introduction
      t.string :icon
      t.string :header

      t.timestamps
    end
  end
end
