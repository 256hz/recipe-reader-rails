class Api::V1::RecipesController < ApplicationController
    before_action :find_recipe, except: [:index]

    def index
        @recipes = Recipe.all
        render json: @recipes
    end

    def steps
        render json: @recipe.steps.sort_by(&:step_no)
    end

    def show
        render json: @recipe
    end

    def ingredients
        render json: @recipe.ingredients
    end

    def equipment
        render json: @recipe.equipments
    end

    private
        def find_recipe
            @recipe = Recipe.all.find_by(spoon_id: params[:id])
            @recipe = Fetcher.get_recipe(params[:id]) if @recipe.nil?
        end    
    
end