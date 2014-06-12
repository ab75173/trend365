class ArticlesController < ApplicationController

  def index
  end

  def search
    @keyword = params[:article][:name]
    nyt_response = get_search_results @keyword
    binding.pry

    # Grabs the headline and ID from each article search result
    @results = nyt_response.map do |article|
      {
        headline: article["headline"]["main"],
        id: article["_id"]
      }
    end
  end

  def show

  end

  private

  def get_search_results(keyword)
    keyword = keyword.gsub(' ', '%20')
    key = Rails.application.secrets[:nyt_api_key]
    results = HTTParty.get("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{keyword}&api-key=#{key}")
    return results["response"]["docs"]
  end


end
