class Recipe < ApplicationRecord
    has_many :steps
    has_many :ingredients

    def parser(recipe)
        puts recipe
    end
end
