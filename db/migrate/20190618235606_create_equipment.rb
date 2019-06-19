class CreateEquipment < ActiveRecord::Migration[5.2]
  def change
    create_table :equipment do |t|
      t.integer :spoon_id
      t.string :name
      t.string :image_url

      t.timestamps
    end
  end
end
