class SearchResultsController < ApplicationController

    skip_before_action :authenticate, only: [:send_results, :edamam_search, :index, :update_ingred_of_result, :update_results_ingredMatch, :update_results_ingredBlock, :undo_results_ingredMatch]

    wrap_parameters format: [], only: [:edamam_search]

    def index
        @search_results = SearchResult.all
        render json: @search_results
    end

    def send_results
        #pagination frontend request - update records displaying on frontend
        @search_result_record = SearchResult.find_record(params)
        render json: @search_result_record
    end

    def edamam_search
        #find SearchResult record 
        @found_search_result_record = SearchResult.find_record(params)
        if @found_search_result_record
            #if record exists, return SearchResult record (JSON, paginated)
            render json: @found_search_result_record
        else
            #get edamam API response, create and return new SearchResult record (JSON, paginated)
            @new_search_result_record = SearchResult.frontend_request(search_params)
            render json: @new_search_result_record
        end
    end

    def update_ingred_of_result
        #find SearchResult record in db
        @search_result = SearchResult.find(params[:id])
        # convert results array JSON string to an array of objects/hashes
        @results_arr_of_hashes = SearchResult.results_arr_fix(@search_result.results)
        #update selected ingredient of search result accordingly
        @updated_results_arr_of_hashes = SearchResult.update_result_ingredient(@results_arr_of_hashes, params)
        #update selected result with updated attributes and convert to JSON string to match backend data structure 
        @search_result.results[params[:resultArrIndex]] = @results_arr_of_hashes[params[:resultArrIndex]].to_json
        #save record to complete record update
        @search_result.save
        #convert newly saved results array from JSON to array of hashes
        @fixed_results_arr = SearchResult.results_arr_fix(@search_result.results)
        #paginate results with appropriate amount of records
        @pagResultsArr = SearchResult.paginate(@fixed_results_arr, params[:pagFrom])
        #create new object to send proper JSON formatted response to frontend with pagination
        @response = {
            id: @search_result.id,
            search_term_key: @search_result.search_term_key,
            search_term: @search_result.search_term,
            from: @search_result.from,
            to: @search_result.to,
            results: @pagResultsArr
        }   
        render json: @response
    end

    


    private
    def search_params
        params.require(:user_id)
        params.permit(:id, :user_id, :search_term_key, :search_term, :from, :to, :pagFrom,
        results: [:name, :image, :source, :ingredientLines, 
                ingredients:[:text, :foodCategory, :ingredMatch, :ingredBlock, :undoIngredMatchObj]
            ]
        )
    end

end
