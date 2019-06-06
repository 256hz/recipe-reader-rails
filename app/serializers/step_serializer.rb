class StepSerializer < ActiveModel::Serializer
  attributes :id, :recipe_id,
    :text, :step_no, :ingredients
end
