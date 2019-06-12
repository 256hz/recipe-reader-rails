class Api::V1::RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
        render json: @recipes
    end

    def show
        @recipe = Fetcher.get_recipe(params[:id])
        render json: @recipe
    end
end