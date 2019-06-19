require 'httparty'

class Fetcher

    # @bacon_brussels_sprouts = {"vegetarian"=>false, "vegan"=>false, "glutenFree"=>true, "dairyFree"=>true, "veryHealthy"=>false, "cheap"=>false, "veryPopular"=>false, "sustainable"=>false, "weightWatcherSmartPoints"=>10, "gaps"=>"no", "lowFodmap"=>false, "ketogenic"=>false, "whole30"=>true, "preparationMinutes"=>20, "cookingMinutes"=>25, "sourceUrl"=>"http://www.foodnetwork.com/recipes/tyler-florence/bacon-and-brussels-sprout-hash-recipe/index.html", "spoonacularSourceUrl"=>"https://spoonacular.com/bacon-and-brussels-sprout-hash-11021", "aggregateLikes"=>145, "spoonacularScore"=>90.0, "healthScore"=>26.0, "creditsText"=>"Foodnetwork", "sourceName"=>"Foodnetwork", "pricePerServing"=>281.91, "extendedIngredients"=>[{"id"=>2069, "aisle"=>"Oil, Vinegar, Salad Dressing", "image"=>"balsamic-vinegar.jpg", "consitency"=>"liquid", "name"=>"balsamic vinegar", "original"=>"2 tablespoons balsamic vinegar", "originalString"=>"2 tablespoons balsamic vinegar", "originalName"=>"balsamic vinegar", "amount"=>2.0, "unit"=>"tablespoons", "meta"=>[], "metaInformation"=>[], "measures"=>{"us"=>{"amount"=>2.0, "unitShort"=>"Tbsps", "unitLong"=>"Tbsps"}, "metric"=>{"amount"=>2.0, "unitShort"=>"Tbsps", "unitLong"=>"Tbsps"}}}, {"id"=>11098, "aisle"=>"Produce", "image"=>"brussels-sprouts.jpg", "consitency"=>"solid", "name"=>"brussels sprouts", "original"=>"2 pints Brussels sprouts, cut in 1/2", "originalString"=>"2 pints Brussels sprouts, cut in 1/2", "originalName"=>"Brussels sprouts, cut in 1/2", "amount"=>2.0, "unit"=>"pints", "meta"=>["cut in 1/2"], "metaInformation"=>["cut in 1/2"], "measures"=>{"us"=>{"amount"=>2.0, "unitShort"=>"pts", "unitLong"=>"pints"}, "metric"=>{"amount"=>2.0, "unitShort"=>"pts", "unitLong"=>"pints"}}}, {"id"=>10111352, "aisle"=>"Frozen", "image"=>"fingerling-potatoes.jpg", "consitency"=>"solid", "name"=>"fingerling potatoes", "original"=>"1 pound fingerling potatoes, split down the middle", "originalString"=>"1 pound fingerling potatoes, split down the middle", "originalName"=>"fingerling potatoes, split down the middle", "amount"=>1.0, "unit"=>"pound", "meta"=>["split"], "metaInformation"=>["split"], "measures"=>{"us"=>{"amount"=>1.0, "unitShort"=>"lb", "unitLong"=>"pound"}, "metric"=>{"amount"=>453.592, "unitShort"=>"g", "unitLong"=>"grams"}}}, {"id"=>11297, "aisle"=>"Produce;Spices and Seasonings", "image"=>"parsley-curly.png", "consitency"=>"solid", "name"=>"flat-leaf parsley", "original"=>"1/4 bunch flat-leaf parsley, leaves roughly chopped", "originalString"=>"1/4 bunch flat-leaf parsley, leaves roughly chopped", "originalName"=>"flat-leaf parsley, leaves roughly chopped", "amount"=>0.25, "unit"=>"bunch", "meta"=>["roughly chopped"], "metaInformation"=>["roughly chopped"], "measures"=>{"us"=>{"amount"=>0.25, "unitShort"=>"bunch", "unitLong"=>"bunches"}, "metric"=>{"amount"=>0.25, "unitShort"=>"bunch", "unitLong"=>"bunches"}}}, {"id"=>2049, "aisle"=>"Produce", "image"=>"thyme.jpg", "consitency"=>"solid", "name"=>"fresh thyme", "original"=>"4 sprigs fresh thyme", "originalString"=>"4 sprigs fresh thyme", "originalName"=>"fresh thyme", "amount"=>4.0, "unit"=>"sprigs", "meta"=>["fresh"], "metaInformation"=>["fresh"], "measures"=>{"us"=>{"amount"=>4.0, "unitShort"=>"sprigs", "unitLong"=>"sprigs"}, "metric"=>{"amount"=>4.0, "unitShort"=>"sprigs", "unitLong"=>"sprigs"}}}, {"id"=>1082047, "aisle"=>"Spices and Seasonings", "image"=>"salt.jpg", "consitency"=>"solid", "name"=>"kosher salt", "original"=>"Kosher salt and freshly ground black pepper", "originalString"=>"Kosher salt and freshly ground black pepper", "originalName"=>"Kosher salt and freshly ground black pepper", "amount"=>6.0, "unit"=>"servings", "meta"=>["black", "freshly ground"], "metaInformation"=>["black", "freshly ground"], "measures"=>{"us"=>{"amount"=>6.0, "unitShort"=>"servings", "unitLong"=>"servings"}, "metric"=>{"amount"=>6.0, "unitShort"=>"servings", "unitLong"=>"servings"}}}, {"id"=>6970, "aisle"=>"Canned and Jarred", "image"=>"chicken-broth.png", "consitency"=>"liquid", "name"=>"low sodium chicken broth", "original"=>"1/2 cup low-sodium chicken broth", "originalString"=>"1/2 cup low-sodium chicken broth", "originalName"=>"low-sodium chicken broth", "amount"=>0.5, "unit"=>"cup", "meta"=>["low-sodium"], "metaInformation"=>["low-sodium"], "measures"=>{"us"=>{"amount"=>0.5, "unitShort"=>"cups", "unitLong"=>"cups"}, "metric"=>{"amount"=>118.294, "unitShort"=>"ml", "unitLong"=>"milliliters"}}}, {"id"=>4053, "aisle"=>"Oil, Vinegar, Salad Dressing", "image"=>"olive-oil.jpg", "consitency"=>"liquid", "name"=>"olive oil", "original"=>"Extra-virgin olive oil", "originalString"=>"Extra-virgin olive oil", "originalName"=>"Extra-virgin olive oil", "amount"=>6.0, "unit"=>"servings", "meta"=>["extra-virgin"], "metaInformation"=>["extra-virgin"], "measures"=>{"us"=>{"amount"=>6.0, "unitShort"=>"servings", "unitLong"=>"servings"}, "metric"=>{"amount"=>6.0, "unitShort"=>"servings", "unitLong"=>"servings"}}}, {"id"=>10411282, "aisle"=>"Produce", "image"=>"red-pearl-onions.jpg", "consitency"=>"solid", "name"=>"red pearl onions", "original"=>"1/2 pound red pearl onions, peeled", "originalString"=>"1/2 pound red pearl onions, peeled", "originalName"=>"red pearl onions, peeled", "amount"=>0.5, "unit"=>"pound", "meta"=>["red", "peeled"], "metaInformation"=>["red", "peeled"], "measures"=>{"us"=>{"amount"=>0.5, "unitShort"=>"lb", "unitLong"=>"pounds"}, "metric"=>{"amount"=>226.796, "unitShort"=>"g", "unitLong"=>"grams"}}}, {"id"=>10310123, "aisle"=>"Meat", "image"=>"raw-bacon.png", "consitency"=>"solid", "name"=>"thick-cut bacon", "original"=>"4 slices thick-cut bacon", "originalString"=>"4 slices thick-cut bacon", "originalName"=>"thick-cut bacon", "amount"=>4.0, "unit"=>"slices", "meta"=>["thick-cut"], "metaInformation"=>["thick-cut"], "measures"=>{"us"=>{"amount"=>4.0, "unitShort"=>"slices", "unitLong"=>"slices"}, "metric"=>{"amount"=>4.0, "unitShort"=>"slices", "unitLong"=>"slices"}}}], "id"=>11021, "title"=>"Bacon and Brussels Sprout Hash", "readyInMinutes"=>45, "servings"=>6, "image"=>"https://spoonacular.com/recipeImages/11021-556x370.jpeg", "imageType"=>"jpeg", "cuisines"=>[], "dishTypes"=>["side dish"], "diets"=>["gluten free", "dairy free", "whole 30"], "occasions"=>[], "winePairing"=>{}, "instructions"=>"Watch how to make this recipe.                    Set a large saute pan over medium heat and add a 2 count of olive oil. Cut bacon into long strips and add to pan together with thyme. Cook for 5 to 7 minutes to render the fat then strain and set aside. Add Brussels sprouts, potatoes and pearl onions. Season with salt and pepper and cook until slightly browned. Add chicken stock and steam for 3 to5 minutes until liquid has evaporated and vegetables are tender. Add balsamic vinegar and toss to coat. Cook until balsamic has reduced then fold in fresh parsley and bacon.", "analyzedInstructions"=>[{"name"=>"", "steps"=>[{"number"=>1, "step"=>"Watch how to make this recipe.", "ingredients"=>[], "equipment"=>[]}, {"number"=>2, "step"=>"Set a large saute pan over medium heat and add a 2 count of olive oil.", "ingredients"=>[{"id"=>4053, "name"=>"olive oil", "image"=>"olive-oil.jpg"}], "equipment"=>[{"id"=>404645, "name"=>"frying pan", "image"=>"pan.png"}]}, {"number"=>3, "step"=>"Cut bacon into long strips and add to pan together with thyme. Cook for 5 to 7 minutes to render the fat then strain and set aside.", "ingredients"=>[{"id"=>10123, "name"=>"bacon", "image"=>"raw-bacon.png"}, {"id"=>2049, "name"=>"thyme", "image"=>"thyme.jpg"}], "equipment"=>[{"id"=>404645, "name"=>"frying pan", "image"=>"pan.png"}], "length"=>{"number"=>5, "unit"=>"minutes"}}, {"number"=>4, "step"=>"Add Brussels sprouts, potatoes and pearl onions. Season with salt and pepper and cook until slightly browned.", "ingredients"=>[{"id"=>11098, "name"=>"brussels sprouts", "image"=>"brussels-sprouts.jpg"}, {"id"=>1102047, "name"=>"salt and pepper", "image"=>"salt-and-pepper.jpg"}, {"id"=>10111282, "name"=>"pearl onion", "image"=>"pearl-onions.png"}], "equipment"=>[]}, {"number"=>5, "step"=>"Add chicken stock and steam for 3 to5 minutes until liquid has evaporated and vegetables are tender.", "ingredients"=>[], "equipment"=>[], "length"=>{"number"=>5, "unit"=>"minutes"}}, {"number"=>6, "step"=>"Add balsamic vinegar and toss to coat. Cook until balsamic has reduced then fold in fresh parsley and bacon.", "ingredients"=>[{"id"=>2069, "name"=>"balsamic vinegar", "image"=>"balsamic-vinegar.jpg"}, {"id"=>11297, "name"=>"fresh parsley", "image"=>"parsley.jpg"}, {"id"=>10123, "name"=>"bacon", "image"=>"raw-bacon.png"}], "equipment"=>[]}]}]}
    # @burger_results = {"results":[{"id":210030,"usedIngredientCount":1,"missedIngredientCount":4,"likes":0,"title":"Aussie burgers","image":"https://spoonacular.com/recipeImages/210030-312x231.jpg","imageType":"jpg","calories":484,"protein":"31g","fat":"25g","carbs":"33g"},{"id":1113770,"usedIngredientCount":1,"missedIngredientCount":7,"likes":0,"title":"Classic Grilled Burgers","image":"https://spoonacular.com/recipeImages/1113770-312x231.jpg","imageType":"jpg","calories":449,"protein":"22g","fat":"34g","carbs":"14g",},{"id":212248,"usedIngredientCount":1,"missedIngredientCount":8,"likes":0,"title":"Chilli burger with roasted tomatoes & red onion relish","image":"https://spoonacular.com/recipeImages/212248-312x231.jpg","imageType":"jpg","calories":545,"protein":"25g","fat":"40g","carbs":"22g",},{"id":1111782,"usedIngredientCount":1,"missedIngredientCount":8,"likes":0,"title":"Chipotle Beef Burger Recipe with Crispy Shallots","image":"https://spoonacular.com/recipeImages/1111782-312x231.jpg","imageType":"jpg","calories":658,"protein":"32g","fat":"39g","carbs":"43g",},{"id":1102442,"usedIngredientCount":1,"missedIngredientCount":14,"likes":0,"title":"Bunless Burger Recipe (Paleo, Whole30 + Keto)","image":"https://spoonacular.com/recipeImages/1102442-312x231.jpg","imageType":"jpg","calories":498,"protein":"22g","fat":"41g","carbs":"11g",}],"baseUri":"https://spoonacular.com/recipeImages/","offset":0,"number":10,"totalResults":5,"processingTimeMs":3792}
    
    def self.key
        ENV.fetch('SPOONACULAR_API_KEY')
    end

    def self.request_search(query)
        HTTParty.get("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/searchComplex?query=#{query}&instructionsRequired=true", 
            headers: 
                {
                    "X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
                    "X-RapidAPI-Key"=> self.key
                }
            )
    end

    def self.search(query)
        response = self.request_search(query)
        # @results = @burger_results
        if response  
            @results = {}
            response["results"].each{ |res| 
                @results[res['title']] = 
                    {
                        id: res['id'], 
                        image_url: res['image'],
                        readyInMinutes: res['readyInMinutes'],
                    } 
            }
        else
            @results={"0001": "No recipes found"}
        end
        puts @results
        @results
    end

    def self.request_recipe(id)
        HTTParty.get("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{id}/information", 
            headers: 
                {
                    "X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
                    "X-RapidAPI-Key"=> self.key
                }
            )
    end

    def self.get_recipe(id)
        # Replace @bacon_brussels_sprouts with the next line to hit the API
        # response = @bacon_brussels_sprouts

        response = self.request_recipe(id) 
        puts response

        @recipe = self.create_recipe(response)
        @ingredients = self.create_ingredients(response, @recipe)
        @steps = self.create_steps(response, @recipe.id, @ingredients)
        self.associate_step_ingredients(@steps)
        @recipe
    end

    def self.create_recipe(response)
        # byebug
        @recipe = Recipe.create(
            cuisines:           response['cuisines'],
            dish_types:         response['dishTypes'],
            image_url:          response['image'],
            is_vegetarian:      response['vegetarian'],
            is_vegan:           response['vegan'],
            likes:              response['aggregateLikes'],
            ready_in_minutes:   response['readyInMinutes'],
            servings:           response['servings'],
            spoon_id:           response['id'],
            source_name:        response['sourceName'],
            source_url:         response['sourceUrl'],
            title:              response['title'],
        )
        @recipe
    end
   
    def self.create_ingredients(response, recipe)
        ingredients = []
        response['extendedIngredients'].each do |ingred|
            puts "ingredient:", ingred['name'], 'spoon_id:', ingred['id']
            @ingred = Ingredient.all.find_by(spoon_id: ingred['id'])
            if @ingred.nil? || @recipe.ingredients.map(&:spoon_id).include?(ingred['id'])
                name = self.filter_name(ingred['name'])
                @ingred = Ingredient.create!(
                    spoon_id:       ingred['id'],
                    name:           name,
                    orig_string:    ingred["originalString"],
                    metric_amount:  self.round_to_fraction(ingred['measures']['metric']['amount']),
                    metric_unit:    ingred['measures']['metric']['unitShort'],
                    us_amount:      self.round_to_fraction(ingred['measures']['us']['amount']),
                    us_unit:        ingred['measures']['us']['unitShort'],
                    image_url:      ingred['image'],
                )
            end
            ri = RecipeIngredient.find_or_create_by(
                recipe_id: recipe.id, 
                ingredient_id: @ingred.id
            )
            puts "created recipe_ingredient id:", ri.id
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