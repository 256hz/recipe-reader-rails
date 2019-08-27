class Api::V1::SpoonController < ApplicationController

  def search
    @results = Fetcher.recipe_search(params[:query])
    render json: @results
  end

  def show
    @recipe = Fetcher.get_recipe(params[:id])
    render json: @recipe
  end

end