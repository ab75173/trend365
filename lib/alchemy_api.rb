require "httparty"

# handles Alchemy API calls and responses
# Docs: http://www.alchemyapi.com/api/
class AlchemyAPI
  attr_reader :options, :response

  # base url for Alchemy API
  BASE_URL = "http://access.alchemyapi.com/"
  API_KEY = Rails.application.secrets['alchemy_api_key']

  def initialize(url)
    @options = {
      :apikey             => API_KEY,
      :keywordExtractMode => "strict",
      :maxRetrieve        => 5,
      :sentiment          => 1,
      :url                => url
    }
  end

  # calls API and extracts keyword sentiment
  def extract_keyword_sentiment
    endpoint = BASE_URL + "calls/url/URLGetRankedKeywords"
    request_params = options.to_query
    request_url = [endpoint, request_params].join("?")

    @response = HTTParty.get( request_url )

    return response["results"]["keywords"]["keyword"]
  end
end