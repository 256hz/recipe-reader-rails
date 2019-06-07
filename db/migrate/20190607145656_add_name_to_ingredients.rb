class AddNameToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :name, :string
  end
end
