class MakeRecipeCuisineArray < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :cuisine
    add_column :recipes, :cuisines, :string, array: true, default: []
  end
end
