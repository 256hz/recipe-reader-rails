require 'spec_helper'

describe 'all recipes route' do
  it 'should return a list of all recipes from /api/v1/recipes' do
    visit '/api/v1/spoon'
    page.should have_content('cuisines')
  end
end