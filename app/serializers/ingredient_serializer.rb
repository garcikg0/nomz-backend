class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :kitchen_id, :name, :storage, :icon, :status, :notes
end
