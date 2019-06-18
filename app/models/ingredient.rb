class Ingredient < ApplicationRecord
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients
    has_many :step_ingredients
    has_many :steps, through: :step_ingredients
end
