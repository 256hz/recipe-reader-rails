class Recipe < ApplicationRecord
    has_many :steps
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    has_many :recipe_equipments
    has_many :equipments, through: :recipe_equipments
end
 