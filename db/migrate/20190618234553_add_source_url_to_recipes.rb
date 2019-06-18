class AddSourceUrlToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :source_url, :string
  end
end
