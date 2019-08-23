require 'httparty'

class Fetcher
  def self.key
    ENV.fetch('SPOONACULAR_API_KEY')
  end

  def self.request_search(query)
    HTTParty.get(
      'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/searchComplex' + 
      "?query=#{query}&instructionsRequired=true",
      headers: { 'X-RapidAPI-Host' => 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
                 'X-RapidAPI-Key' => key }
    )
  end

  def self.search(query)
    response = request_search(query)
    if response
      @results = {}
      response['results'].each do |res|
        @results[res['title']] = { id: res['id'], 
                                   image_url: res['image'],
                                   readyInMinutes: res['readyInMinutes'] }
      end
    else
      @results = { '0001': 'No recipes found' }
    end
    # puts @results
    @results
  end

  def self.request_recipe(id)
    HTTParty.get('https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/' + 
                 "recipes/#{id}/information", 
                 headers: { 'X-RapidAPI-Host' => 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
                            'X-RapidAPI-Key' => key }
    )
  end

  def self.get_recipe(id)
    response = request_recipe(id) 
    puts response

    @recipe = create_recipe(response)
    @ingredients = create_ingredients(response, @recipe)
    @steps = create_steps(response, @recipe.id, @ingredients)
    associate_step_ingredients(@steps)
    @recipe
  end

  def self.create_recipe(response)
    @recipe = Recipe.create(
      cuisines: response['cuisines'],
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
      title: response['title']
    )
    @recipe
  end

  def self.create_ingredients(response, recipe)
    ingredients = []
    response['extendedIngredients'].each do |ingred|
      # puts "ingredient:", ingred['name'], 'spoon_id:', ingred['id']
      @ingred = Ingredient.all.find_by(spoon_id: ingred['id'])
      if @ingred.nil? || @recipe.ingredients.map(&:spoon_id).include?(ingred['id'])
        name = filter_name(ingred['name'])
        @ingred = Ingredient.create!(
          spoon_id: ingred['id'],
          name: name,
          orig_string: ingred['originalString'],
          metric_amount: round_to_fraction(ingred['measures']['metric']['amount']),
          metric_unit: ingred['measures']['metric']['unitShort'],
          us_amount: round_to_fraction(ingred['measures']['us']['amount']),
          us_unit: ingred['measures']['us']['unitShort'],
          image_url: ingred['image']
        )
      end
      ri = RecipeIngredient.find_or_create_by(recipe_id: recipe.id,
                                              ingredient_id: @ingred.id)
      puts 'created recipe_ingredient id:', ri.id
      ingredients.push(@ingred)
    end
    ingredients
  end

    def self.round_to_fraction(float, denominator=4)
        (float * denominator).round.to_f/denominator
    end

    def self.filter_name(name)
        words_to_strip = ['fresh', 'green', 'red']
        words_to_strip.each {|word| 
            name = name.split.filter{|el| el != word}.join(" ")
        }
        name
    end

    def self.create_equipment(equipment, recipe_id, step_id)
        puts 'creating equipment'
        puts equipment, recipe_id, step_id
        equipment.each{|item|
            puts "item:", item
            @equip = Equipment.find_by(spoon_id: item['id'])
            if @equip.nil?
                puts 'equipment not found, creating:', item['id'], item['name'], item['image']
                @equip = Equipment.create!(
                    spoon_id: item['id'],
                    name: item['name'],
                    image_url: item['image']
                )
                puts 'equip created:', @equip
            end
            RecipeEquipment.find_or_create_by!(
                equipment_id: @equip.id,
                recipe_id: recipe_id
            )
            StepEquipment.create!(
                equipment_id: @equip.id,
                step_id: step_id
            )
        }
    end

    def self.create_steps(response, id, ingredients)
        steps = []
        # byebug
        response['analyzedInstructions'][0]['steps'].each do |step|
            # puts "Step ingredients:", step['ingredients']
            # puts "Step ingredient Spoon IDs:", step['ingredients'].map{|i| i['id'].to_s}
            step_spoon_ids = self.get_spoon_ids(step['step'], ingredients)
            @step = Step.create!(
                recipe_id:      id,
                step_no:        step['number'],
                text:           step['step'],
                spoon_ids:      step_spoon_ids
                )
            self.create_equipment(step["equipment"], id, @step.id) if step['equipment']
            steps.push(@step)
        end
        steps
    end

    def self.get_spoon_ids(text, ingredients)
        spoon_ids = []
        puts "Searching: #{text}"
        ingredients.each {|i|
            split_name = i.name.downcase.split
            # puts "Looking for: #{i.name} or #{split_name}"
            if text.downcase.include?(i.name)
                spoon_ids << i.spoon_id
                puts "found, inserting: #{i.name}, #{i.spoon_id}"
            end
            split_name.each{|word|
                if text.include?(word) && !spoon_ids.include?(i.spoon_id)
                    spoon_ids << i.spoon_id
                    puts "found, inserting: #{i.name}, #{i.spoon_id}"
                end
            }
        }
        puts "spoon_ids: #{spoon_ids}"
        spoon_ids
    end

    def self.associate_step_ingredients(steps)
        puts "Associating steps with ingredients"
        steps.each{ |step_i|
            if step_i['spoon_ids'] != []
                puts " Step spoon_ids: #{ step_i['spoon_ids'] } "
                step_i['spoon_ids'].each{ |spoon_id|
                    ingred = Ingredient.all.find_by(spoon_id: spoon_id)
                    puts "found ingredient: #{ingred.name}"
                    puts "making StepIngredient with step_id: #{step_i.id}, ingred_id: #{ingred.id}"
                    StepIngredient.create!(step_id: step_i.id, ingredient_id: ingred.id)
                }
            end
        }
    end

end