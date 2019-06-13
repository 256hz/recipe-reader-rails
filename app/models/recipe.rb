class Recipe < ApplicationRecord
    has_many :steps
    has_many :ingredients

    def self.send_steps(recipe)
        puts recipe
    end
end
