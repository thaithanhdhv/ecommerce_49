class CreateOderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :oder_details do |t|
      t.integer :quantity
      t.decimal :price
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
