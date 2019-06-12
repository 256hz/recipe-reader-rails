class Api::V1::RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
        render json: @recipes
    end

    def show
        @recipe = Recipe.all.find_by(spoon_id: params[:id])
        if @recipe
            @recipe = Recipe.send_steps(@recipe)
        else
            @recipe = Fetcher.get_recipe(params[:id])
        end
        render json: @recipe
    end
end