class RemoveIngredientIdsFromSteps < ActiveRecord::Migration[5.2]
  def change
    remove_column :steps, :ingredient_ids
  end
end
