class Equipment < ApplicationRecord
  has_many :recipe_equipments
  has_many :recipes, through: :recipe_equipments
  has_many :step_equipments
  has_many :steps, through: :step_equipments
end
