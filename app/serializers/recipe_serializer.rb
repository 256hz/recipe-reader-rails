class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :spoon_id,
    :title, :image_url,
    :is_vegetarian, :is_vegan,
    :ready_in_minutes, :servings,
    :steps_length,
    :source_name, :likes,
    :cuisines, :dish_types,
    :ingredients
end
