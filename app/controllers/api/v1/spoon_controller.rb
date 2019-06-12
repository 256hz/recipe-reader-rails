class Api::V1::SpoonController < ApplicationController
  def search
    @results = Fetcher.search(params[:query])
    render json: @results
  end

  def index
    @recipes = Recipe.all
    render json: @recipes
  end
end