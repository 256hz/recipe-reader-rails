class Step < ApplicationRecord
    belongs_to :recipe
    has_many :step_ingredients
    has_many :ingredients, through: :step_ingredients
    has_many :step_equipments
    has_many :equipments, through: :step_equipments
end
