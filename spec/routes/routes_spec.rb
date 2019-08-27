require 'rails_helper'

feature 'Recipes index (spoon#index)' do
  def expect_content(arg)
    expect(page).to have_content(arg)
  end

  scenario 'Root should redirect to API root' do
    visit '/'
    expect_content('Recipe Reader')
  end

  scenario 'API root should display app title' do
    visit '/api/v1/'
    expect_content('Recipe Reader')
  end

  scenario 'Return a specific recipe from /api/v1/recipes/:id' do
    visit '/api/v1/recipes/224260'
    expect_content('cuisines')
  end

  scenario 'Return a recipe\'s ingredients from /api/v1/recipes/:id/ingredients' do
    visit '/api/v1/recipes/224260/ingredients'
    expect_content('4 red peppers')
    expect_content('spoon_id')
    expect_content('name')
    expect_content('metric_amount')
    expect_content('metric_unit')
    expect_content('us_amount')
    expect_content('us_unit')
    expect_content('image_url')
    expect_content('2 x 400g cans chickpea, rinsed and drained')
    expect_content('huge bunch parsley, roughly chopped')
    expect_content('1 red chilli, deseeded and chopped')
    expect_content('2 garlic cloves, finely chopped')
    expect_content('100ml olive oil')
    expect_content('600g cleaned squid, sliced into rings, tentacles kept whole')
    expect_content('200g cooking chorizo, cut into chickpea-size chunks')
    expect_content('juice of lemon')
  end

  scenario 'Return a recipe\'s equipment from /api/v1/recipes/:id/equipment' do
    visit '/api/v1/recipes/224260/equipment'
    expect_content('frying pan')
    expect_content('bowl')
    expect_content('griddle')
    expect_content('grill')
  end

  scenario 'Return a recipe\'s steps from /api/v1/recipes/:id/steps' do
    visit '/api/v1/recipes/224260/steps'
    expect_content('Heat a large frying pan until smoking. Working quickly and carefully, add a splash of oil to the pan, then the squid. Stir-fry for about 30 secs. Scatter the chorizo over the squid, continue to cook for 30 secs more, then tip into the bowl with the peppers. Season everything with salt and pepper, then dress with the remaining oil, lemon juice and lemon zest.')
  end

  scenario 'Return search results for "mac and cheese" from /api/v1/spoon/:query' do
    visit '/api/v1/spoon/mac%20and%20cheese'
    expect_content('Mac and Cheese Bites')
    expect_content('Garlic Bread Crusted Gnocchi Mac and Cheese')
    expect_content('One Pot Chili Con Queso Mac and Cheese')
    expect_content('Slow Cooker Buffalo Chicken Mac and Cheese')
  end

end