Recipe.destroy_all
Step.destroy_all
Ingredient.destroy_all
StepIngredient.destroy_all

# Fetcher.get_recipe(320451)
# Fetcher.get_recipe(829385)
Fetcher.get_recipe(11021)

# recipe1=Recipe.create!( 
#     spoon_id: 479101,
#     title: "On the Job: Pan Roasted Cauliflower From Food52",
#     cuisines: [],
#     image_url: "https://spoonacular.com/recipeImages/479101-556x370.jpg",
#     ready_in_minutes: 20,
#     is_vegetarian: false,
#     is_vegan: false,
#     source_name: "Feed Me Phoebe",
#     likes: 225,
#     servings: 4,
#     dish_types: ["side dish"],
#     steps_length: 4
# )

# step1=Step.create!(
#         recipe_id: recipe1.id,
#         step_no: 0,
#         text: "Cut the florets off the stems and and then chop them into tiny florets. You can also chop up the stems into tiny pieces if you want. You should have about 6 cups of chopped cauliflower. In a large skillet heat 2 tablespoons of olive oil over medium-high heat.",
#     )

# step2=Step.create(
#         recipe_id: recipe1.id,
#         step_no: 1,
#         text: "Add the cauliflower, 1 teaspoon of salt, rosemary, and sumac. Sauté until cauliflower is tender and starts to brown a bit, stirring as necessary, about 15 minutes. You can also add a bit of olive oil if the pan starts to get too dry or the cauliflower is starting to stick. Meanwhile, in a small skillet, toast the pinenuts over medium heat until golden brown. Set aside.",
#         ingredient_ids: [11135, 4053, 12147, 10211111, 2047]
#     )

# ingred1=Ingredient.create!(
#     recipe_id: recipe1.id,
#     spoon_id: 11135,
#     metric_amount: 1,
#     metric_unit: "head",
#     us_amount: 1,
#     us_unit: "head",
#     image_url: "cauliflower.jpg"
# )

# ingred2=Ingredient.create(
#     recipe_id: recipe1.id,
#     spoon_id: 18079,
#     metric_amount: 118.294,
#     metric_unit: "ml",
#     us_amount: 0.5,
#     us_unit: "cup",
#     image_url: "breadcrumbs.jpg"
# )

# StepIngredient.create!(step_id:step1.id, ingredient_id:ingred1.id)
# StepIngredient.create(step_id:step1.id, ingredient_id:ingred2.id)