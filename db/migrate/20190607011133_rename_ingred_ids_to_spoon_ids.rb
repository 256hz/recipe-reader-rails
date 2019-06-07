class RenameIngredIdsToSpoonIds < ActiveRecord::Migration[5.2]
  def change
    rename_column :steps, :ingred_ids, :spoon_ids
  end
end
