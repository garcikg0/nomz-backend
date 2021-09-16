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
    byebug
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
    byebug
    @fixedResultsArr = SearchResult.results_arr_fix(@search.results)
    byebug
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
end




