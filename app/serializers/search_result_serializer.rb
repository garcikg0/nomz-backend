class SearchResultSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :search_term_key, :results, :search_term, :from, :to
  # has_one :user
end
