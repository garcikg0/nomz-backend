class SearchResult < ApplicationRecord
  belongs_to :user
  # create method to take params and convert into an object
  def self.frontend_request(params)
    api_url = "https://api.edamam.com/search?q="
    api_key = "&app_id=0b82cc58&app_key=261ccdef93fe9904029ee5ff77011f79"
    @url = "#{api_url}#{params[:search_term]}#{api_key}&from=#{params[:from]}&to=#{params[:to]}"
    @response = Faraday.get(@url, {'Accept' => 'applicaton/json'})
    @resJSON = JSON.parse(@response.body)
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
    # byebug
    return @results
  end
  
end



