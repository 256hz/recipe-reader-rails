class AddIngredientsToSteps < ActiveRecord::Migration[5.2]
  def change
    add_column :steps, :ingred_ids, :string, array: true, default: []
  end
end
