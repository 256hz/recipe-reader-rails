# API root controller
class Api::V1::IndexController < ApplicationController
  def index
    @page = "Welcome to the Recipe Reader Ruby on Rails API Backend.\n\n" +
            "To see a list of all recipes in the database, visit\n\n" +
            '/api/v1/spoon'
    render json: @page
  end
end
