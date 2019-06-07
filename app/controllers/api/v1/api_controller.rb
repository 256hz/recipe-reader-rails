class Api::V1::ApiController < ApplicationController
  def search
    @results={}
    response = Fetcher.burger_search.body
    response["results"].each{|res| @results[res['id']] = res['title']}
    render json: @results
  end

  def index
    @recipe = Fetcher.get_recipe(592863)
    render json: @recipe
  end
end