class Api::V1::RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
        render json: @recipes
    end

    def show
        @recipe = Recipe.all.find_by(spoon_id: params[:id])
        if @recipe
            render json: @recipe.steps.sort_by(&:step_no)
        else
            @recipe = Fetcher.get_recipe(params[:id])
            render json: @recipe.steps.sort_by(&:step_no)
        end
    end

    def ingredients
        @recipe = Fetcher.get_recipe(params[:id])
        @ingredients = Ingredient.all.filter{|i| i.recipe_id == @recipe.id}
        render json: @ingredients
    end
end