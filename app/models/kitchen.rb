class Kitchen < ApplicationRecord
  belongs_to :user
  has_many :ingredients
  has_many :recipes
end
