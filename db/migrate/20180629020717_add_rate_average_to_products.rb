class AddRateAverageToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :rate_average, :float
  end
end
