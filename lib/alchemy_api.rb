require "httparty"

# Extracts keyword sentiments using Alchemy API
# Docs: http://www.alchemyapi.com/api/
class AlchemyAPI
  attr_reader :options, :response

  BASE_URL = "http://access.alchemyapi.com/"              # Base url for Alchemy API
  API_KEY = Rails.application.secrets["alchemy_api_key"]  # API KEY


  # A new instance takes two arguments
  # * url (required) - a well-formed URL to the target document you want to extract

  # * options (optional) - a hash with the following optional API request parameters:
  #   - keywordExtractMode: defaults to "strict"
  #   - maxRetrieve: defaults to 5
  #   - sentiment: defaults to 1
  def initialize(url, options = {})
    @options = {
      :apikey             => API_KEY,
      :keywordExtractMode => options[:keywordExtractMode] || "strict",
      :maxRetrieve        => options[:maxRetrieve]        || 10,
      :sentiment          => options[:sentiment]          || 1,
      :url                => url
    }
  end

  # Makes a call to the Alchemy API to extract keyword sentiment
  def extract_keyword_sentiment
    # Build the request URL for the API call
    endpoint = BASE_URL + "calls/url/URLGetRankedKeywords"
    request_params = options.to_query
    request_url = [endpoint, request_params].join("?")

    # Make the request
    @response = HTTParty.get request_url

    # If results are returned, traverse the response and return keyword data
    # Keyword data is in @response["results"]["keywords"]["keyword"] as of 6/12/14
    %w( results keywords keyword ).reduce(response) do |data, key|
      return nil unless data.has_key? key
      data = data[key]
    end
  end
end
