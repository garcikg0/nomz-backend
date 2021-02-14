class IconSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_link, :ingredients
end
