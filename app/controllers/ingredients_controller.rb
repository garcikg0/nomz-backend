class IngredientsController < ApplicationController

    # skip_before_action :authenticate, only: [:create]

    def index
        @ingredients = Ingredient.all 
        render json: @ingredients
    end

    def show
        @ingredient = Ingredient.find(params[:id])
        render json: @ingredient
    end

    def create
        ingredient = Ingredient.create(ingredient_params)
        render json: @ingredient
    end

    def update
        @ingredient = Ingredient.find(params[:id])
        ingredient.update(ingredient_params)
        render json: @ingredient
    end

    def destroy
        @ingredient = Ingredient.find(params[:id])
        @ingredient.destroy
        render json: @ingredient
    end

    private

    def ingredient_params
        params.require(:ingredient).permit(:name, :storage, :icon, :status, :notes)
    end
end
