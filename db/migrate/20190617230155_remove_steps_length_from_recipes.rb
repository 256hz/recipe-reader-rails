class RemoveStepsLengthFromRecipes < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :steps_length
  end
end
