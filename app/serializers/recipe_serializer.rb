class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :image, :source, :url, :ingredient_lines, :ingredients
  
end
