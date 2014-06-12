class ArticlesController < ApplicationController

  def index
  end

  def search
    @keyword = params[:article][:name]
    nyt_response = call_NYT_API q: @keyword

    if nyt_response
      # Grabs the headline and ID from each article search result
      @results = nyt_response.map do |article|
        { id: article["_id"],
          headline: article["headline"]["main"] }
      end
    end
  end

  def show
    #if id params has letters in it, it is NYTimes ID (not persisted) and new Favorite
    if (/[A-z]/) =~ params[:id]
      nyt_id = params[:id]
      @favorite = Favorite.new

    else #if id params doesn't have letters in it, it is Trend365 ID (is persisted) and existing Favorite
      @favorited = true
      @favorite = Favorite.find(params[:id])
      nyt_id = @favorite.nyt_id
    end

    #grab info from API regardless, using nyt_id from conditional
    nyt_response = call_NYT_API(fq: "_id:(\"#{nyt_id}\")")[0]

    if nyt_response
      @result = {
        :headline => nyt_response["headline"]["main"],
        :snippet  => nyt_response["snippet"],
        :url      => nyt_response["web_url"],
        :date     => nyt_response["pub_date"].to_s[0..9]
      }
    end
  end

  def create
    # params coming from hidden fields in "save" form/button
    @favorite = Favorite.create({
      nyt_id: params[:nyt_id],
      title: params[:title],
      user_id: params[:user_id]
    })
    redirect_to favorite_path(@favorite)
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to root_path
  end

  private
  # Calls the NYT API, expects a hash of options that correspond to NYT API params
  # http://developer.nytimes.com/docs/read/article_search_api_v2
  def call_NYT_API(options = {})
    # Build request URL for NYT API
    base_url = "http://api.nytimes.com/svc/search/v2/articlesearch.json"
    params = { :"api-key" => Rails.application.secrets[:nyt_api_key] }
    params.merge! options
    request_url = [base_url, params.to_query].join("?")

    # Get results
    results = HTTParty.get request_url

    # Check if there are any results returned & return them
    # Otherwise, return nil if there are no results
    %w( response docs ).reduce(results) do |data, key|
      return nil unless data[key]
      data = data[key]
    end
  end
end
