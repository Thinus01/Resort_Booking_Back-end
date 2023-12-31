class CreateResorts < ActiveRecord::Migration[7.0]
  def change
    create_table :resorts do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :location
      t.float :price
      t.text :description
      t.integer :guests_amount
      t.string :image_url
      t.timestamps
    end
  end
end
