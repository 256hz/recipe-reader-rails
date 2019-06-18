class RecipeSerializer < ActiveModel::Serializer
  attributes 
    :cuisines, 
    :dish_types,
    :ingredients, 
    :id, 
    :image_url,
    :is_vegetarian, 
    :is_vegan,
    :likes,
    :ready_in_minutes, 
    :servings,
    :source_name, 
    :steps
    :source_url,
    :spoon_id,
    :title, 
end
