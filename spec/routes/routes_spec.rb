require 'rails_helper'

feature 'Recipes index (spoon#index)' do
  scenario 'Root should redirect to API root' do
    visit '/'
    expect(page).to have_content('Recipe Reader')
  end

  scenario 'API root should display app title' do
    visit '/api/v1/'
    expect(page).to have_content('Recipe Reader')
  end

  scenario 'Return a list of all recipes from /api/v1/spoon' do
    visit '/api/v1/spoon'
    expect(page).to have_content('cuisines')
  end
end