class SentimentsController < ApplicationController
  def index
    # Get sentiment from AlchemyAPI for the specified URL
    api = AlchemyAPI.new params[:url]
    @keywords = api.extract_keyword_sentiment

    # Return keyword sentiment data as JSON
    if @keywords
      render json: @keywords
    else
      head :bad_request
    end
  end
end
