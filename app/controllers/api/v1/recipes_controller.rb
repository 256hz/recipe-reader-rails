class Api::V1::RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
        render json: @recipes
    end

    def steps
        @recipe = Recipe.all.find_by(spoon_id: params[:id])
        if @recipe
            render json: @recipe.steps.sort_by(&:step_no)
        else
            @recipe = Fetcher.get_recipe(params[:id])
            render json: @recipe.steps.sort_by(&:step_no)
        end
    end

    def show
        @recipe = Recipe.all.find_by(spoon_id: params[:id])
        @recipe = Fetcher.get_recipe(params[:id]) if @recipe.nil? 
        render json: @recipe
    end

    def ingredients
        @recipe = Recipe.all.find_by(spoon_id: params[:id])
        @recipe = Fetcher.get_recipe(params[:id]) if @recipe.nil? 

        render json: @recipe.ingredients
    end
end