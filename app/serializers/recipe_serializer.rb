class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :source, :url, :ingredient_lines, :ingredients
  has_one :kitchen
end
