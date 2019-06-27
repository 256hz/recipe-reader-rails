# RECIPE READER

<image src="/public/images/title-screen.png" /><image src="/public/images/search-results.png" /><image src="/public/images/step.png" /><image src="/public/images/done.png" />

### Overview

If you like to cook, you have probably been through the following scenario: you find a recipe on your phone, get in deep, and have to stop, wash your hands, unlock your phone, and scroll around to find the next step, for what seems like hundreds of times.  This app solves that problem!  Now you can find a great recipe, and once you start cooking, you won't have to touch your phone at all*.  

This repo is the Ruby on Rails API backend for the [React Native mobile app](https://github.com/256hz/recipe-reader-react-v4).  It interfaces with the Spoonacular API to find recipes, get ingredients, and parse recipe steps.

### Installation (OSX)

- Clone this repo.
- If you don't have Postgres running locally, install [Postgres.app](https://postgresapp.com/downloads.html).
- From the root directory, run `bundle install && rails db:setup && rails db:migrate`.
- Get a [Spoonacular API key](https://spoonacular.com/api/docs/recipes-api).  Side note, the Spoonacular API is a best-in-class product and the team deserves great praise.  This app wouldn't be possible without their service.
- Once you have your API key, store it in the environment variable `SPOONACULAR_API_KEY`.  A guide to setting environment variables in OSX can be found [here](https://medium.com/@himanshuagarwal1395/setting-up-environment-variables-in-macos-sierra-f5978369b255).
- In your terminal, run `rails db:seed`.  This fetches a single recipe from the API via the `Fetcher` model (`/app/models/Fetcher.rb`). Fetcher then breaks it down into a `Recipe`, `Ingredients`, `Equipments`, and `Steps`, and associates them through various join tables.
- Run `rails s`, and load `http://localhost:3000/api/v1/recipes` in your browser.  
  - In `/config/routes.rb`, everything has been `namespace`d inside `api/v1/`.  If you don't wish to follow this convention, simply remove the two `namespace` method calls.  
- The output from `/recipes/` should look something like this:

<image src="/public/images/api-response.png" />

Once you get back good responses, you can host and create your remote database.  

- Upload to hosting (for example, [Heroku](http://www.heroku.com).  A good guide to deploying a Rails/React app on Heroku can be found [here](https://medium.com/coding-in-simple-english/deploying-rails-react-app-to-heroku-35e1829242ab).
- If you're on Heroku, run `heroku login`, then `heroku run rails db:migrate && heroku run rails db:seed`.  
  - There's no need to run `db:setup`, as Heroku takes care of this step for you.
- Test your API endpoints as you did locally.

You're done!  Now you can move on to the [React Native](https://github.com/256hz/recipe-reader-react-v4) portion.

### In Progress

I am adding a number of features, including:
- Better Text-to-Speech from Google Cloud
- Speech-to-Text, also from Google Cloud
  - Voice control: next/previous step
- Search filters
- Tumbler(not Tumblr)-style step navigation
- Speech on/off control
