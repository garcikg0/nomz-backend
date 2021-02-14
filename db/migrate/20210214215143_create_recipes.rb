class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.belongs_to :kitchen, null: false, foreign_key: true
      t.string :name
      t.string :image
      t.string :source
      t.string :url
      t.string :ingredient_lines
      t.string :ingredients

      t.timestamps
    end
  end
end
