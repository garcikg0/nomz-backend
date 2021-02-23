class RemoveKitchenIdFromRecipes < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :recipes, :kitchens
  end
end
