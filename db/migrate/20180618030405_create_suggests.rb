class CreateSuggests < ActiveRecord::Migration[5.1]
  def change
    create_table :suggests do |t|
      t.string :title
      t.string :image
      t.decimal :price
      t.text :content
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
