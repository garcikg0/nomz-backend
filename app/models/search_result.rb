class SearchResult < ApplicationRecord
  belongs_to :user
  
  def self.recipe_ingred_fix(ingredientsArr)
    @ingred = ingredientsArr.map do |res| 
      {
        text: res["text"],
        foodCategory: res["foodCategory"]
      }
    end
    return @ingred
  end

  def self.results_arr_fix(resultsArr)
    #parse resultsArr in JSON into a data structure - array of hashes
    @newResultsArr = resultsArr.map do |res|
      JSON.parse(res)
    end
    #return array of hashes of resultsArr in JSON
    return @newResultsArr
  end

  def self.paginate(resultsArr, from)
    @arr = resultsArr
    @results = @arr[from, 20]
    return @results
  end
  
  def self.frontend_request(params)
    # create url for edamam get request
    api_url = "https://api.edamam.com/search?q="
    api_key = "&app_id=0b82cc58&app_key=261ccdef93fe9904029ee5ff77011f79"
    @url = "#{api_url}#{params[:search_term]}#{api_key}&from=#{params[:from]}&to=#{params[:to]}"
    # get API response with results
    @response = Faraday.get(@url, {'Accept' => 'application/json'}) 
    # JSON parse API response.body
    @resJSON = JSON.parse(@response.body)
    # get array of recipe objects from response
    @tempRecipe = @resJSON["hits"]
    # map through array of recipe objects with needed key value pairs
    @results = @tempRecipe.map do |res|
      {
        name: res["recipe"]["label"],
        image: res["recipe"]["image"],
        source: res["recipe"]["source"],
        url: res["recipe"]["url"],
        ingredientLines: res["recipe"]["ingredientLines"],
        ingredients: recipe_ingred_fix(res["recipe"]["ingredients"])
      }
    end
    # map through results object to return JSON string representing the model
    @results_json = @results.map do |res|
      res.to_json
    end
    #create & save API response to backend as a new record 
    @search = SearchResult.create(
      user_id: params[:user_id],
      search_term_key: params[:search_term_key],
      search_term: params[:search_term],
      from: params[:from],
      to: params[:to],
      results: @results_json
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
    #return SearchResult record 
    return @response
  end

  def self.find_record(params)
    #find SearchResult record in db
    if params[:id] == nil
      @backend_results = SearchResult.find_by(search_term: params[:search_term], from: params[:from], to: params[:to])
    else
      @backend_results = SearchResult.find(params[:id])
    end
    # if no results, return nil to create new SearchResult record
    if !@backend_results
      return nil
    else 
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
    end
    #return SearchResult record
    return @response
  end

  def self.update_ingred(params, ingredient)
    @ingredient_to_update = ingredient
    #if ingredMatch request
    if params[:ingredMatchObj]
      #define ingred obj to add to ingredMatch arr
      @ingred_obj = {
        id: params[:ingredMatchObj]["id"],
        kitchen_id: params[:ingredMatchObj]["kitchen_id"],
        name: params[:ingredMatchObj]["name"],
        storage: params[:ingredMatchObj]["storage"],
        icon: params[:ingredMatchObj]["icon"],
        status: params[:ingredMatchObj]["status"],
        notes: params[:ingredMatchObj]["notes"]
      }
      #if there is an ingredMatch array already defined
      if @ingredient_to_update["ingredMatch"]
        #copy of previous ingredMatch array
        @ingredMatch_arr = @ingredient_to_update["ingredMatch"]
        #define ingredMatch arr by using splat to copy previous ingredMatch array and add ingred obj requested to be added as an ingredMatch
        @ingredient_to_update["ingredMatch"] = [*@ingredMatch_arr, @ingred_obj]
      else
        #if no ingredMatch array already define, then define ingredMatch array in ingedient to update object and add ingred obj requested to be added as an IngredMatch
        @ingredient_to_update["ingredMatch"] = [@ingred_obj]
      end
      #return updated ingredient
      return @ingredient_to_update
    #if ingredBlock request  
    elsif params[:ingredBlockObj]
      #define ingred obj to add to ingredBlock arr
      @ingred_obj = {
        id: params[:ingredBlockObj]["id"],
        kitchen_id: params[:ingredBlockObj]["kitchen_id"],
        name: params[:ingredBlockObj]["name"],
        storage: params[:ingredBlockObj]["storage"],
        icon: params[:ingredBlockObj]["icon"],
        status: params[:ingredBlockObj]["status"],
        notes: params[:ingredBlockObj]["notes"]
      }
      #if there is an ingredBlock array already defined
      if @ingredient_to_update["ingredBlock"]
        #copy of previous ingredBlock array
        @ingredBlock_arr = @ingredient_to_update["ingredBlock"]
        #define ingredBlock arr by using splat to copy previous ingredBlock array and add ingred obj requested to be added as an ingredBlock
        @ingredient_to_update["ingredBlock"] = [*@ingredBlock_arr, @ingred_obj]
      else
        #if no ingredBlock array already define, then define ingredBlock array in ingedient to update object and add ingred obj requested to be added as an IngredBlock
        @ingredient_to_update["ingredBlock"] = [@ingred_obj]
      end
      #return updated ingredient
      return @ingredient_to_update

    #if undo ingredMatch request  
    elsif params[:ingredMatchUndoObj]
      #iterate through ingredMatch array of ingredient and delete ingredient object that has the same id as requested in params
      @ingredient_to_update["ingredMatch"].each do |ingred|
        if (ingred["id"] == params[:ingredMatchUndoObj][:id])
          @ingredient_to_update["ingredMatch"].delete(ingred)
        end
      end
      #return updated ingredient
      return @ingredient_to_update
    end
  end

  def self.update_result_ingredient(result_arr, params)
    @results_arr_of_hashes = result_arr
    #find result to update
    @result_to_update = @results_arr_of_hashes[params[:resultArrIndex]]
    #find ingredient to update
    @ingredient_to_update = @result_to_update["ingredients"][params[:ingredArrIndex]]
    #update ingredient whether there was an ingredMatchObj, ingredBlockObj, or ingredMatchUndoObj in params from frontend request
    @updated_ingredient = SearchResult.update_ingred(params, @ingredient_to_update)
    #return results array of hashes - the selected ingredient is updated in @result_to_update as well as @results_arr_of_hashes
    return @results_arr_of_hashes
  end

end




