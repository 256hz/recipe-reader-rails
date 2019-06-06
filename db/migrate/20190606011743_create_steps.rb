class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.integer :recipe_id
      t.string :ingeredient_ids
      t.string :text

      t.timestamps
    end
  end
end
