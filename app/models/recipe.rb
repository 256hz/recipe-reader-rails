class Recipe < ApplicationRecord
    has_many :steps
    has_many :ingredients

    def send_steps(recipe)
        puts recipe
    end
end
