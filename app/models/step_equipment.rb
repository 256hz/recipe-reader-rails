class StepEquipment < ApplicationRecord
  belongs_to :step
  belongs_to :equipment
end
