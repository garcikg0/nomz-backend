class CreateSearchResults < ActiveRecord::Migration[6.0]
  def change
    create_table :search_results do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :search_term_key
      t.string :search_term
      t.string :from
      t.string :to
      t.string :results, array: true, default: []
    end
  end
end
