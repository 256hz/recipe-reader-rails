class CreateStepIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :step_ingredients do |t|
      t.integer :step_id
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
