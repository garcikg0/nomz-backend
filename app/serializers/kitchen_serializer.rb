class KitchenSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :ingredients
  has_many :ingredients
end
