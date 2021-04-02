class SearchResultsController < ApplicationController

    skip_before_action :authenticate, only: [:edamam_search, :index]

    wrap_parameters format: [], only: [:edamam_search]

    def index
        @search_results = SearchResult.all
        render json: @search_results
    end

    def edamam_search
        @api_res = SearchResult.frontend_request(search_params)
        @search = SearchResult.create(
            user_id: params[:user_id],
            search_term_key: params[:search_term_key],
            search_term: params[:search_term],
            from: params[:from],
            to: params[:to],
            results: @api_res
        )
        @fixedResultsArr = SearchResult.results_arr_fix(@search.results)
        @response = {
            id: @search.id,
            search_term_key: @search.search_term_key,
            search_term: @search.search_term,
            from: @search.from,
            to: @search.to,
            results: @fixedResultsArr
        }
        render json: @response
    end

    private
    def search_params
        params.require(:user_id)
        params.permit(:user_id, :search_term_key, :search_term, :from, :to, 
        results: [:name, :image, :source, :ingredientLines, 
                ingredients:[:text, :foodCategory]
            ]
        )
    end

end
