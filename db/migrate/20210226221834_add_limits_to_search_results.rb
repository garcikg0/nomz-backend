class AddLimitsToSearchResults < ActiveRecord::Migration[6.0]
  def change
    add_column :search_results, :from, :int
    add_column :search_results, :to, :int
  end
end
