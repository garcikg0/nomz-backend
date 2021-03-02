class CreateSearchResults < ActiveRecord::Migration[6.0]
  def change
    create_table :search_results, id: false, primary_key: :search_term_key do |t|
      t.primary_key :search_term_key
      t.belongs_to :user, null: false, foreign_key: true
      t.string :results, array: true, default: []

      t.timestamps
    end
  end
end
