class Fetcher

    # class << self

    def self.key
        ENV.fetch('SPOONACULAR_API_KEY')
    end

    def self.burger_search
        Unirest.get("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?&query=burger",
            headers:{
                "X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
                "X-RapidAPI-Key" => self.key
            }
        )
    end

    def self.request_recipe(id)
        Unirest.get("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{id}/information",
            headers:{
                "X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
                "X-RapidAPI-Key" => self.key
            }
        )
    end

    def self.get_recipe(id)
        response = self.request_recipe(id).body
        @recipe = self.create_recipe(response)
        @ingredients = self.create_ingredients(response, @recipe.id)
        puts "*"*50
        puts "ingredient spoon ids"
        @ingredients.each{|i| puts i.spoon_id}
        puts "*"*50
        @steps = self.create_steps(response, @recipe.id)
        puts "*"*50
        puts "step spoon ids"
        @steps.each{|s| puts s.spoon_ids}
        puts "*"*50
        self.associate_step_ingredients(@steps)
        @recipe
    end

    def self.create_recipe(response)
        @recipe = Recipe.create(
            spoon_id:           response['id'],
            title:              response['title'],
            image_url:          response['image'],
            ready_in_minutes:   response['readyInMinutes'],
            is_vegetarian:      response['vegetarian'],
            is_vegan:           response['vegan'],
            source_name:        response['sourceName'],
            likes:              response['aggregateLikes'],
            steps_length:       response['analyzedInstructions'][0]['steps'].length,
            cuisines:           response['cuisines'],
            servings:           response['servings'],
            dish_types:         response['dishTypes'],
        )
        @recipe
    end
   
    def self.create_ingredients(response, id)
        ingredients = []
        response['extendedIngredients'].each do |ingred|
            # byebug
            @ingred = Ingredient.create!(
                spoon_id:       ingred['id'],
                recipe_id:      id,
                metric_amount:  ingred['measures']['metric']['amount'],
                metric_unit:    ingred['measures']['metric']['unitShort'],
                us_amount:      ingred['measures']['us']['amount'],
                us_unit:        ingred['measures']['us']['unitShort'],
                image_url:      ingred['image'],
            )
            ingredients.push(@ingred)
        end
        ingredients
    end

    def self.create_steps(response, id)
        steps = []
        # byebug
        response['analyzedInstructions'][0]['steps'].each do |step|
            @step = Step.create!(
                recipe_id:      id,
                step_no:        step['number'],
                text:           step['step'],
                spoon_ids:     step['ingredients'].map{|i| i['id'].to_s}
            )
            steps.push(@step)
        end
        steps
    end

    def self.associate_step_ingredients(steps)
        steps.each{ |step_i|
            puts "-"*50
            puts "step_i.id:",  step_i.id, "step_i.spoon_ids:", step_i['spoon_ids']
            puts "-"*50
            if step_i['spoon_ids'] != []
                puts "I'm goin in"
                step_i['spoon_ids'].each{ |spoon_id|
                    if spoon_id && step_i.id
                        puts "-"*50
                        puts "spoon_id:", spoon_id, "step_i.id:", step_i.id
                        ingred_in_DB = Ingredient.find_by(spoon_id: spoon_id.to_i)
                        puts "ingred_in_DB.id:", ingred_in_DB.id
                        puts "-"*50
                        # byebug
                        si = StepIngredient.new(step_id: step_i.id, ingredient_id: ingred_in_DB.id)
                        si.save!
                    end
                }
            end
        }
    end

end