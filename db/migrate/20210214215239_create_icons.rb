class CreateIcons < ActiveRecord::Migration[6.0]
  def change
    create_table :icons do |t|
      t.string :name
      t.string :description
      t.string :image_link
      t.string :ingredients

      t.timestamps
    end
  end
end
