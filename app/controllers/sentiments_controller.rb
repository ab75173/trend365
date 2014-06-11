class SentimentsController < ApplicationController
  def index
    api = AlchemyAPI.new url: params[:url]
    @keywords = api.extract_keyword_sentiment

    if @keywords
      render json: @keywords
    else
      head :bad_request
    end
  end
end