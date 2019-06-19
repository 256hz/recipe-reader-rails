class AddEquipmentIdsToSteps < ActiveRecord::Migration[5.2]
  def change
    add_column :steps, :equipment_ids, :string, default: [], array: true
  end
end
