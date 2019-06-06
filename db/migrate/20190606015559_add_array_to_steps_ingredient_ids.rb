class AddArrayToStepsIngredientIds < ActiveRecord::Migration[5.2]
  def change
    remove_column :steps, :ingeredient_ids
    add_column :steps, :ingredient_ids, :string, array: true, default: []
  end
end
