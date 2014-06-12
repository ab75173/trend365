class ArticlesController < ApplicationController

  def index
  end

  def search
    @keyword = params[:article][:name]
    nyt_response = get_search_results @keyword

    # Grabs the headline and ID from each article search result

    @results = nyt_response.map do |article|
      { id: article["_id"],
      headline: article["headline"]["main"] }
    end

  end

  def show
    nyt_response = get_specific_article(params[:id])[0]

    @result = {
      :headline => nyt_response["headline"]["main"],
      :snippet  => nyt_response["snippet"],
      :url      => nyt_response["web_url"],
    }
    @favorite = Favorite.new
  end

  private
  def get_specific_article(id)
    base_url = "http://api.nytimes.com/svc/search/v2/articlesearch.json"
    params = {
      :fq        => "_id:(\"#{id}\")",
      :"api-key" => Rails.application.secrets[:nyt_api_key]
    }
    request_url = [base_url, params.to_query].join("?")

    results = HTTParty.get request_url

    return results["response"]["docs"]
  end

  def get_search_results(keyword)
    keyword = keyword.gsub(' ', '%20')
    key = Rails.application.secrets[:nyt_api_key]
    results = HTTParty.get("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{keyword}&api-key=#{key}")
    return results["response"]["docs"]
  end


end
