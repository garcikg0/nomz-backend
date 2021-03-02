class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :username, :email, :bio, :kitchens, :recipes
  has_many :recipes
  has_many :kitchens
  has_many :search_results
end
