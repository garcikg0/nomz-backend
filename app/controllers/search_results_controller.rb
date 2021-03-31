class SearchResultsController < ApplicationController

    skip_before_action :authenticate, only: [:edamam_search, :index]

    wrap_parameters format: [], only: [:edamam_search]

    def index
        @search_results = SearchResult.all
        render json: @search_results
    end

    def edamam_search
        @api_res = SearchResult.frontend_request(search_params)
        byebug
        @search = SearchResult.create(
            user_id: params[:user_id],
            search_term_key: params[:search_term_key],
            search_term: params[:search_term],
            from: params[:from],
            to: params[:to],
            results: @api_res
        )
        byebug
        @eval = eval(@search.results)
        @search_result = SearchResult.find(@search.id)
        @search_result.update(results: @eval)
        render json: @search_result
    end

    private
    def search_params
        params.require(:user_id)
        params.permit(:user_id, :search_term_key, :search_term, :from, :to, results: [
            :name,
            :image,
            :source,
            :url,
            :ingredientLines,
            :ingredients
        ])
    end

end
