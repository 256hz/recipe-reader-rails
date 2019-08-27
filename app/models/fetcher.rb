require 'httparty'

# Calls the Spoonacular API for recipe search and recipe steps.
# Order of operations:
# SEARCH: search, request_search
# RECIPE:
#   get_recipe
#     request_recipe
#     create_recipe
#     create_ingredients
#     create_steps
#       get_spoon_ids
#     associate_step_ingredients

class Fetcher
  def self.key
    # Returns the API key from the environment
    ENV.fetch('SPOONACULAR_API_KEY')
  end

  def self.recipe_search(query)
    responses = request_search(query)
    return_search_results(responses['results'])
  end

  def self.request_search(query)
    # Performs Spoonacular(S11r)'s 'complex recipe' search -- simple search seems to be down.
    # Returns JSON results that include instructions with step associations.
    HTTParty.get(
      'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/searchComplex' +
      "?query=#{query}&instructionsRequired=true",
      headers: { 'X-RapidAPI-Host' => 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
                 'X-RapidAPI-Key' => key }
    )
  end

  def self.return_search_results(responses)
    # Searches for recipes from S11r and returns them in a @results hash.
    if responses
      responses.each_with_object({}) do |response, hash|
        hash[response['title']] = { id: response['id'],
                                    image_url: response['image'],
                                    readyInMinutes: response['readyInMinutes'] }
      end
    else
      { 'None' => 'No recipes found' }
    end
  end

  def self.get_recipe(id)
    # Runner method for getting a recipe.
    # - gets the recipe from S11r
    # - creates a Recipe to associate everything with
    # - creates Ingredients & RecipeIngredients joins for this recipe
    # - creates Steps & RecipeSteps joins
    # - creates StepIngredient joins.
    response = request_recipe(id)
    # puts response
    @recipe = create_recipe(response)
    @ingredients = create_ingredients(response, @recipe)
    @steps = create_steps(response, @recipe.id, @ingredients)
    associate_step_ingredients(@steps)
    @recipe
  end

  def self.request_recipe(id)
    # Return a single recipe's instructions and equipment in JSON.
    HTTParty.get('https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/' +
                 "recipes/#{id}/information",
                 headers: { 'X-RapidAPI-Host' => 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
                            'X-RapidAPI-Key' => key })
  end

  def self.create_recipe(response)
    # Create a new Recipe in the DB.
    @recipe = Recipe.create(cuisines: response['cuisines'],
                            dish_types: response['dishTypes'],
                            image_url: response['image'],
                            is_vegetarian: response['vegetarian'],
                            is_vegan: response['vegan'],
                            likes: response['aggregateLikes'],
                            ready_in_minutes: response['readyInMinutes'],
                            servings: response['servings'],
                            spoon_id: response['id'],
                            source_name: response['sourceName'],
                            source_url: response['sourceUrl'],
                            title: response['title'])
    @recipe
  end

  def self.create_ingredients(response, recipe)
    # Makes Ingredients if they don't already exist.  Associates all with the Recipe.
    ingredients = []
    response['extendedIngredients'].each do |ingred|
      # puts "ingredient:", ingred['name'], 'spoon_id:', ingred['id']
      @ingred = Ingredient.all.find_by(spoon_id: ingred['id'])
      if @ingred.nil? || @recipe.ingredients.map(&:spoon_id).include?(ingred['id'])
        @ingred = Ingredient.create!(spoon_id: ingred['id'],
                                     # see filter_name comments below
                                     name: filter_name(ingred['name']),
                                     orig_string: ingred['originalString'],
                                     metric_amount: round_to_fraction(ingred['measures']['metric']['amount']),
                                     metric_unit: ingred['measures']['metric']['unitShort'],
                                     us_amount: round_to_fraction(ingred['measures']['us']['amount']),
                                     us_unit: ingred['measures']['us']['unitShort'],
                                     image_url: ingred['image'])
      end
      ri = RecipeIngredient.find_or_create_by(recipe_id: recipe.id, ingredient_id: @ingred.id)
      # puts 'created recipe_ingredient id:', ri.id
      ingredients.push(@ingred)
    end
    ingredients
  end

  def self.round_to_fraction(float, denominator = 4)
    # The API often returns amounts in long floats, probably as a result of
    # automated conversion to/from metric.  This rounds to the nearest quarter,
    # unless another denominator is specified.
    (float * denominator).round.to_f / denominator
  end

  def self.filter_name(name)
    # This is a janky way to remove very common words from the Ingredient name,
    # which helps prevent false positives when associating StepIngredients later.
    words_to_strip = %w[fresh green red]
    words_to_strip.each do |word|
      name = name.split.filter { |el| el != word }.join(' ')
    end
    name
  end

  def self.create_steps(response, recipe_id, ingredients)
    # Creates Steps from the response and associates ingredents & recipe.
    # If the step has equipment, it creates it below in create_equipment.
    # I don't like that the create_equipment call is coupled this function,
    # good refactor target.
    steps = []
    response['analyzedInstructions'][0]['steps'].each do |step|
      # puts "Step ingredients:", step['ingredients']
      # puts "Step ingredient Spoon IDs:", step['ingredients'].map{|i| i['id'].to_s}
      step_spoon_ids = get_spoon_ids(step['step'], ingredients)
      @step = Step.create!(recipe_id: recipe_id,
                           step_no: step['number'],
                           text: step['step'],
                           spoon_ids: step_spoon_ids)
      create_equipment(step['equipment'], recipe_id, @step.id) if step['equipment']
      steps.push(@step)
    end
    steps
  end

  def self.create_equipment(equipment, recipe_id, step_id)
    # Takes a list of equipment from the Step created above, creates each one,
    # and joins it with the step and recipe.
    # puts 'creating equipment'
    # puts equipment, recipe_id, step_id
    equipment.each do |item|
      # puts 'item:', item
      @equip = Equipment.find_by(spoon_id: item['id'])
      if @equip.nil?
        # puts 'equipment not found, creating:', item['id'], item['name'], item['image']
        @equip = Equipment.create!(spoon_id: item['id'],
                                   name: item['name'],
                                   image_url: item['image'])
        # puts 'equip created:', @equip
      end
      RecipeEquipment.find_or_create_by!(equipment_id: @equip.id, recipe_id: recipe_id)
      StepEquipment.create!(equipment_id: @equip.id, step_id: step_id)
    end
  end

  def self.get_spoon_ids(text, ingredients)
    # Sometimes, the API returns different ingredients in the step than it does in
    # the Recipe's extendedIngredients field (e.g., cherry jam vs. raspberry).
    # This searches the ingredients list for word matches, i.e., cherry jam
    # would match rasbperry jam due to the common word 'jam'.  Very janky in that
    # this causes problems with multiple types of the same ingredient, but that
    # isn't super common.
    spoon_ids = []
    # puts "Searching: #{text}"
    ingredients.each do |i|
      # puts "Looking for: #{i.name}"
      # Checks for an exact match in the ingredients list.
      if text.downcase.include?(i.name)
        spoon_ids << i.spoon_id 
      # puts "found, inserting: #{i.name}, #{i.spoon_id}"
      else
        split_name = i.name.downcase.split
        split_name.each do |word|
          spoon_ids << i.spoon_id if text.include?(word) && !spoon_ids.include?(i.spoon_id)
          # puts "found, inserting: #{i.name}, #{i.spoon_id}"
        end
      end
    end
    # puts "spoon_ids: #{spoon_ids}"
    spoon_ids
  end

  def self.associate_step_ingredients(steps)
    # Finally, we can associate the Steps with their Ingredients.
    steps.each do |step_i|
      # puts "Associating #{step_i} with ids: #{step_i['spoon_ids']}"
      next if step_i['spoon_ids'] == []

      # puts " Step spoon_ids: #{ step_i['spoon_ids'] } "
      step_i['spoon_ids'].each do |spoon_id|
        ingred = Ingredient.all.find_by(spoon_id: spoon_id)
        # puts "found ingredient: #{ingred.name}"
        # puts "making StepIngredient with step_id: #{step_i.id}, ingred_id: #{ingred.id}"
        StepIngredient.create!(step_id: step_i.id, ingredient_id: ingred.id)
      end
    end
  end
end
