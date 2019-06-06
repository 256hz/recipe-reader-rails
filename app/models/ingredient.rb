class Ingredient < ApplicationRecord
    belongs_to :recipe
    has_many :step_ingredients
    has_many :steps, through: :step_ingredients
end
