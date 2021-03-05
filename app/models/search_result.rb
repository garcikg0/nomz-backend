class SearchResult < ApplicationRecord
  belongs_to :user
  
  def self.search_check
    
  end
  
  
  def self.frontend_request(params)
    # create url for edamam get request
    api_url = "https://api.edamam.com/search?q="
    api_key = "&app_id=0b82cc58&app_key=261ccdef93fe9904029ee5ff77011f79"
    @url = "#{api_url}#{params[:search_term]}#{api_key}&from=#{params[:from]}&to=#{params[:to]}"
    # get API response with results
    @response = Faraday.get(@url, {'Accept' => 'applicaton/json'})
    # JSON parse API response.body
    @resJSON = JSON.parse(@response.body)
    # map through array of recipe objects with needed key value pairs
    @tempRecipe = @resJSON["hits"]
    @results = @tempRecipe.map do |res|
      {
        name: res["recipe"]["label"],
        image: res["recipe"]["image"],
        source: res["recipe"]["source"],
        url: res["recipe"]["url"],
        ingredientLines: res["recipe"]["ingredientLines"],
        ingredients: res["recipe"]["ingredients"]
      }
    end
    # return array
    return @results
  end
  
end



