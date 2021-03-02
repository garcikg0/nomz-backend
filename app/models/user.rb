class User < ApplicationRecord
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }

    has_many :kitchens
    has_many :ingredients, through: :kitchens
    has_many :recipes
    has_many :search_results
end
