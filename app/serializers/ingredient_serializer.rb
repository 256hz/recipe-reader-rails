class IngredientSerializer < ActiveModel::Serializer
  attributes :id, 
  :spoon_id, 
  :name,
  :metric_amount, 
  :metric_unit, 
  :us_amount, 
  :us_unit,
  :image_url, 
  :orig_string
end
