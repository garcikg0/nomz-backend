class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :storage, :icon, :status, :notes
end
