class KitchenSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :ingredients, :recipes
  has_many :ingredients
  has_many :recipes
end
