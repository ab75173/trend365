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
    nyt_response = get_specific_article(nyt_id)[0]
    @date = nyt_response["pub_date"].to_s[0..9]
    @result = {
      :headline => nyt_response["headline"]["main"],
      :snippet  => nyt_response["snippet"],
      :url      => nyt_response["web_url"],
      :date     => @date
    }
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
