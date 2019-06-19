class CreateRecipeEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_equipments do |t|
      t.integer :recipe_id
      t.integer :equipment_id

      t.timestamps
    end
  end
end
