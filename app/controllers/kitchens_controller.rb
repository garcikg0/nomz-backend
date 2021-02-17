class KitchensController < ApplicationController

    skip_before_action :authenticate

    def test
        @kitchen = Kitchen.find(params[:id])
        render json: @kitchen
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
        kitchen.update(kitchen_params)
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
