class RecipeEquipment < ApplicationRecord
  belongs_to :recipe
  belongs_to :equipment
end
