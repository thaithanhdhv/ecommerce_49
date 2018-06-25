    class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :address
      t.string :remeber_token
      t.integer :role, null: false, default: 0
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
