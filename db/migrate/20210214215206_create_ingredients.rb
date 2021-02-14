class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.belongs_to :kitchen, null: false, foreign_key: true
      t.string :name
      t.string :storage
      t.string :icon
      t.string :status
      t.string :notes

      t.timestamps
    end
  end
end
