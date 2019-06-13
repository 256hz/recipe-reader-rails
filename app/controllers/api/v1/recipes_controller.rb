class Api::V1::RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
        render json: @recipes
    end

    def show
        @recipe = Recipe.all.find_by(spoon_id: params[:id])
        if @recipe
            render json: @recipe
        else
            @recipe = Fetcher.get_recipe(params[:id])
            render json: @recipe
        end
    end
end