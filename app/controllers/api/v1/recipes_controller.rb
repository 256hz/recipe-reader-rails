class Api::V1::RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
        render json: @recipes
    end
end