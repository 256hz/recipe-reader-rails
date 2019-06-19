class RenameTableEquipmentEquipments < ActiveRecord::Migration[5.2]
  def change
    rename_table :equipment, :equipments
  end
end
