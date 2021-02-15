class IconsController < ApplicationController

    skip_before_action :authenticate

    def index
        @icons = Icon.all
        render json: @icons
    end

    def show
        @icon = Icon.find(params[:id])
        render json: @icon
    end

    def create
        @icon = Icon.create(icon_params)
        render json: @icon
    end

    def update
        @icon = Icon.find(params[:id])
        icon.update(icon_params)
        render json: @icon
    end

    def destroy
        @icon = Icon.find(params[:id])
        @icon.destroy
        render json: @icon
    end

    private
    def icon_params
        params.permit(:name, :description, :image_link, :ingredients)
    end
end
