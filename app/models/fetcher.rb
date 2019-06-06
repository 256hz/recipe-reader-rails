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

end