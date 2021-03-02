class RecipesController < ApplicationController

    skip_before_action :authenticate

    def index
        @recipes = Recipe.all
        render json: @recipes
    end

    def show
        @recipe = Recipe.find(params[:id])
        render json: @recipe
    end

    def create
        @recipe = Recipe.create(recipe_params)
        render json: @recipe
    end

    def update
        @recipe = Recipe.find(params[:id])
        @recipe.update(recipe_params)
        render json: @recipe
    end

    def destroy
        @recipe = Recipe.find(params[:id])
        @recipe.destroy
        render json: @recipe
    end

    private
    def recipe_params
        params.permit(:id, :user_id, :name, :image, :source, :url, :ingredient_lines, :ingredients)
    end
    
end
