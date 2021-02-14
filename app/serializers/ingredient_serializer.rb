class IngredientSerializer < ActiveModel::Serializer
  attributes :name, :storage, :icon, :status, :notes
  has_one :kitchen
end
