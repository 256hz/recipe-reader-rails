class Recipe < ApplicationRecord
    has_many :steps
    has_many :ingredients
end
