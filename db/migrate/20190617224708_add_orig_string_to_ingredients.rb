class AddOrigStringToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :orig_string, :string
  end
end
