class Api::V1::SpoonController < ApplicationController
  def search
    @results = Fetcher.search(params[:query])
    render json: @results
  end

  def index
    @recipe = Fetcher.get_recipe(592863)
    render json: @recipe
  end
end