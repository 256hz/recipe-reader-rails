class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.integer :spoon_id
      t.integer :recipe_id
      t.integer :metric_amount
      t.string :metric_unit
      t.integer :us_amount
      t.string :us_unit
      t.string :image_url

      t.timestamps
    end
  end
end
