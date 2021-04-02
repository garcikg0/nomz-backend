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
    # return array of recipe objects
    return @results
  end

  def self.results_arr_fix(resultsArr)
    @newResultsArr = resultsArr.map do |res|
      eval(res)
  end
  return @newResultsArr
  end
  
end



