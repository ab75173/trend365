class ArticlesController < ApplicationController

  def index
  end

  def search
    @keyword = params[:article][:name]
    @results = get_search_results(@keyword)
  end


  private

  def get_search_results(keyword)
    keyword = keyword.gsub(' ', '%20')
    key = Rails.application.secrets[:nyt_api_key]
    results = HTTParty.get("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{keyword}&api-key=#{key}")
    binding.pry
    return results["response"]["docs"]
  end


end
