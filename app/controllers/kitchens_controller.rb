class KitchensController < ApplicationController

    skip_before_action :authenticate, only: [:index, :show, :create, :update, :destroy]

    def test
        render json: @current_kitchen_user
    end
    
    def index
        @kitchens = Kitchen.all
        render json: @kitchens
    end

    def show
        @kitchen = Kitchen.find(params[:id])
        render json: @kitchen
    end

    def create 
        @kitchen = Kitchen.create(kitchen_params)
        render json: @kitchen
    end

    def update
        @kitchen = Kitchen.find(params[:id])
        @kitchen.update(kitchen_params)
        render json: @kitchen
    end

    def destroy
        @kitchen = Kitchen.find(params[:id])
        @kitchen.destroy
        render json: @kitchen
    end

    private
    def kitchen_params
        params.permit(:id, :name, :user_id)
    end
end
