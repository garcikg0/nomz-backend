class SearchResultsController < ApplicationController

    skip_before_action :authenticate, only: [:send_results, :edamam_search, :index, :update_results_ingredMatch, :update_results_ingredBlock, :undo_results_ingredMatch]

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

    def update_results_ingredMatch
        #find SearchResult record that needs to be updated
        @search_result = SearchResult.find(params[:id])
        #define :results of selected SearchResult record (:results is an array of strings)
        @results = @search_result.results
        # convert :results to an array of objects/hashes
        @results_arr_of_hashes = SearchResult.results_arr_fix(@results)
        #find result to update
        @result_to_update = @results_arr_of_hashes[params[:resultArrIndex]]
        #find ingredient to update
        @ingredient_to_update = @result_to_update["ingredients"][params[:ingredArrIndex]]
        #define ingredMatch ingred object (value for :ingredMatchObj key)
        @ingred_obj = {
            id: params[:ingredMatchObj]["id"],
            kitchen_id: params[:ingredMatchObj]["kitchen_id"],
            name: params[:ingredMatchObj]["name"],
            storage: params[:ingredMatchObj]["storage"],
            icon: params[:ingredMatchObj]["icon"],
            status: params[:ingredMatchObj]["status"],
            notes: params[:ingredMatchObj]["notes"]
        }
        #check if there is already an ingredMatch. 
        if @ingredient_to_update[:ingredMatch]
            #if there is an ingredMatch, then add ingred_obj to existing array using splat operator (equivalent to JavaScript spread operator) 
            @ingredMatch_arr = @ingredient_to_update[:ingredMatch]
            @ingredient_to_update[:ingredMatch] = [*@ingredMatch_arr, @ingred_obj]
        else
            #else set value of :ingredMatch key to an arry with ingred object to backend ingred object. This updates instance variables up to @results_arr_of_hashes.
            @ingredient_to_update[:ingredMatch] = [@ingred_obj]
        end
        #update selected result with updated attributes and convert to string to match backend data structure 
        @search_result.results[params[:resultArrIndex]] = @results_arr_of_hashes[params[:resultArrIndex]].to_s
        #save record to complete record update
        @search_result.save
        #convert newly saved SearchResult record's :results array from array of strings to array of hashes
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

    def update_results_ingredBlock
        #find SearchResult record that needs to be updated
        @search_result = SearchResult.find(params[:id])
        #define :results of selected SearchResult record (:results is an array of strings)
        @results = @search_result.results
        # convert :results to an array of objects/hashes
        @results_arr_of_hashes = SearchResult.results_arr_fix(@results)
        #find result to update
        @result_to_update = @results_arr_of_hashes[params[:resultArrIndex]]
        #find ingredient to update
        @ingredient_to_update = @result_to_update["ingredients"][params[:ingredArrIndex]]
        #define ingredBlock ingred object (value for :ingredBlockObj key)
        @ingred_obj = {
            id: params[:ingredBlockObj]["id"],
            kitchen_id: params[:ingredBlockObj]["kitchen_id"],
            name: params[:ingredBlockObj]["name"],
            storage: params[:ingredBlockObj]["storage"],
            icon: params[:ingredBlockObj]["icon"],
            status: params[:ingredBlockObj]["status"],
            notes: params[:ingredBlockObj]["notes"]
        }
        #check if there is already an ingredBlock. 
        if @ingredient_to_update[:ingredBlock]
            #if there is an ingredBlock, then add ingred_obj to existing array using splat operator (equivalent to JavaScript spread operator) 
            @ingredBlock_arr = @ingredient_to_update[:ingredBlock]
            @ingredient_to_update[:ingredBlock] = [*@ingredBlock_arr, @ingred_obj]
        else
            #else set value of :ingredBlock key to an arry with ingred object to backend ingred object. This updates instance variables up to @results_arr_of_hashes.
            @ingredient_to_update[:ingredBlock] = [@ingred_obj]
        end
        #update selected result with updated attributes and convert to string to match backend data structure 
        @search_result.results[params[:resultArrIndex]] = @results_arr_of_hashes[params[:resultArrIndex]].to_s
        #save record to complete record update
        @search_result.save
        #convert newly saved SearchResult record's :results array from array of strings to array of hashes
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

    def undo_results_ingredMatch
        #find SearchResult record that needs to be updated
        @search_result = SearchResult.find(params[:id])
        #define :results of selected SearchResult record (:results is an array of strings)
        @results = @search_result.results
        # convert :results to an array of objects/hashes
        @results_arr_of_hashes = SearchResult.results_arr_fix(@results)
        #find result to update
        @result_to_update = @results_arr_of_hashes[params[:resultArrIndex]]
        #find ingredient to update
        @ingredient_to_update = @result_to_update[:ingredients][params[:ingredArrIndex]]
        #params[:ingredMatchObj] is aleady the ingredObj we want to get rid of. Iterate through ingredMatch array to find ingredObj we want to remove from ingredMatch array
        @ingredient_to_update[:ingredMatch].each do |ingredObj|
            if (ingredObj[:id] == params[:ingredMatchObj][:id])
                @ingredient_to_update[:ingredMatch].delete(ingredObj)
            end 
        end
        #update selected result with updated attributes and convert to string to match backend data structure 
        @search_result.results[params[:resultArrIndex]] = @results_arr_of_hashes[params[:resultArrIndex]].to_s
        #save record to complete record update
        @search_result.save
        #convert newly saved SearchResult record's :results array from array of strings to array of hashes
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
                ingredients:[:text, :foodCategory, :ingredMatch, :ingredBlock]
            ]
        )
    end

end
