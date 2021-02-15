class IconSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_link, :ingredients
  # has_many :ingredients
end
