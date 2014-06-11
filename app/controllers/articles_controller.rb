class ArticlesController < ApplicationController

  def index
  end

  def search
    @results = get_search_results(keyword)
  end


  private

  def get_search_results(keyword)
    keyword = keyword.gsub(' ', '%20')
    key = Rails.application.secrets[:nyt_api_key]
    results = HTTParty.get("http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=#{keyword}&api-key=#{key}")
    return results["response"]["docs"]
  end


end
