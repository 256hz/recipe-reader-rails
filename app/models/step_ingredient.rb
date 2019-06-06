class StepIngredient < ApplicationRecord
    belongs_to :step
    belongs_to :ingredient
end
