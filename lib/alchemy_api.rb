require "httparty"

# handles Alchemy API calls and responses
# Docs: http://www.alchemyapi.com/api/
class AlchemyAPI
  attr_reader :options, :response

  # base url for Alchemy API
  BASE_URL = "http://access.alchemyapi.com/"
  API_KEY = Rails.application.secrets['alchemy_api_key']

  def initialize(options)
    @options = {
      :apikey             => API_KEY,
      :keywordExtractMode => options[:keywordExtractMode] || "strict",
      :maxRetrieve        => options[:maxRetrieve]        || 5,
      :sentiment          => options[:sentiment]          || 1,
      :url                => options[:url]
    }
  end

  # extracts keyword sentiment based on specified options
  def extract_keyword_sentiment
    endpoint = BASE_URL + "calls/url/URLGetRankedKeywords"
    request_params = options.to_query
    request_url = [endpoint, request_params].join("?")

    @response = HTTParty.get( request_url )

    # if results are returned, then traverse response and return data
    %w( results keywords keyword ).reduce(response) do |data, key|
      return nil unless data.has_key? key
      data = data[key]
    end
  end
end