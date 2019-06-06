class AddDishTypesToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :dish_types, :string, array: true, default: []
  end
end
