class RemoveRecipeIdFromIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :recipe_id, :string
  end
end
