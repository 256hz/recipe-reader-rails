class ChangeAmountsToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :ingredients, :us_amount, :float
    change_column :ingredients, :metric_amount, :float
  end
end
