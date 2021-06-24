class SearchResultsController < ApplicationController

    skip_before_action :authenticate, only: [:send_results, :edamam_search, :index, :update_results]

    wrap_parameters format: [], only: [:edamam_search]

    def index
        @search_results = SearchResult.all
        render json: @search_results
    end

    def send_results
        @backend_results = SearchResult.find(params[:id])
        #change results to proper array of objects - removing str data type
        @fixedResultsArr = SearchResult.results_arr_fix(@backend_results.results)
        #paginate results with appropriate amount of records
        @pagResultsArr = SearchResult.paginate(@fixedResultsArr, params[:pagFrom])
        #create new object to send proper JSON formatted response to frontend with pagination
        @response = {
            id: @backend_results.id,
            search_term_key: @backend_results.search_term_key,
            search_term: @backend_results.search_term,
            from: @backend_results.from,
            to: @backend_results.to,
            results: @pagResultsArr
        }   
        render json: @response
    end

    def edamam_search
        if params[:id] == nil
            if SearchResult.find_by(search_term: params[:search_term], from: params[:from], to: params[:to])
                @backend_results = SearchResult.find_by(search_term: params[:search_term], from: params[:from], to: params[:to])
                #change results to proper array of objects - removing str data type
                @fixedResultsArr = SearchResult.results_arr_fix(@backend_results.results)
                #paginate results with appropriate amount of records
                @pagResultsArr = SearchResult.paginate(@fixedResultsArr, params[:pagFrom])
                #create new object to send proper JSON formatted response to frontend with pagination
                @response = {
                    id: @backend_results.id,
                    search_term_key: @backend_results.search_term_key,
                    search_term: @backend_results.search_term,
                    from: @backend_results.from,
                    to: @backend_results.to,
                    results: @pagResultsArr
                }   
                render json: @response 
            else
                #get edamam API response
                @api_res = SearchResult.frontend_request(search_params)
                #save API response to backend as a new record 
                @search = SearchResult.create(
                    user_id: params[:user_id],
                    search_term_key: params[:search_term_key],
                    search_term: params[:search_term],
                    from: params[:from],
                    to: params[:to],
                    results: @api_res
                )
                #change results to proper array of object - removing str data type
                @fixedResultsArr = SearchResult.results_arr_fix(@search.results)
                #paginate results with appropriate amount of records
                @pagResultsArr = SearchResult.paginate(@fixedResultsArr, params[:from])
                #create new object to send proper JSON formatted response to frontend with pagination
                @response = {
                    id: @search.id,
                    search_term_key: @search.search_term_key,
                    search_term: @search.search_term,
                    from: @search.from,
                    to: @search.to,
                    results: @pagResultsArr
                }   
                render json: @response
            end
        else
            #find SearchResult record by id 
            @backend_results = SearchResult.find(params[:id])
             #change results to proper array of objects - removing str data type
            @fixedResultsArr = SearchResult.results_arr_fix(@backend_results.results)
            #paginate results with appropriate amount of records
            @pagResultsArr = SearchResult.paginate(@fixedResultsArr, params[:pagFrom])
            #create new object to send proper JSON formatted response to frontend with pagination
            @response = {
                id: @backend_results.id,
                search_term_key: @backend_results.search_term_key,
                search_term: @backend_results.search_term,
                from: @backend_results.from,
                to: @backend_results.to,
                results: @pagResultsArr
            }   
            render json: @response
        end
    end

    def update_results
        @search_result = SearchResult.find(params[:id])
        @results = @search_result.results
        @result_to_update = eval(@results[params[:resultArrIndex]])
        @ingredient_to_update = @result_to_update[:ingredients][params[:ingredArrIndex]]
        @ingred_obj = {
            id: params[:ingredMatchObj]["id"],
            kitchen_id: params[:ingredMatchObj]["kitchen_id"],
            name: params[:ingredMatchObj]["name"],
            storage: params[:ingredMatchObj]["storage"],
            icon: params[:ingredMatchObj]["icon"],
            status: params[:ingredMatchObj]["status"],
            notes: params[:ingredMatchObj]["notes"]
        }
        @ingredient_to_update[:ingredMatch] = @ingred_obj
        @results[params[:resultArrIndex]] = @result_to_update.to_s
        @updated_search_result = {
            id: @search_result.id,
            user_id: @search_result.user_id,
            search_term_key: @search_result.search_term_key,
            search_term: @search_result.search_term, 
            from: @search_result.from,
            to: @search_result.to, 
            results: @results
        }
        @search_result.update(@updated_search_result)
        byebug
        @fixed_results_arr = SearchResult.results_arr_fix(@search_result.results)
        # byebug
        render json: @fixed_results_arr
    end



    private
    def search_params
        params.require(:user_id)
        params.permit(:id, :user_id, :search_term_key, :search_term, :from, :to, :pagFrom,
        results: [:name, :image, :source, :ingredientLines, 
                ingredients:[:text, :foodCategory, :ingredMatch, :ingredBlock]
            ]
        )
    end

end
