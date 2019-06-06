class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :spoon_id
      t.string :title
      t.string :cuisine
      t.string :image_url
      t.integer :ready_in_minutes
      t.boolean :is_vegetarian
      t.boolean :is_vegan
      t.string :source_name
      t.integer :likes
      t.integer :steps_length

      t.timestamps
    end
  end
end
