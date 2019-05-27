class Api::V1::GifsController < ApplicationController
  def index
    search_param = params[:search]
    render json: {}, status: :bad_request if search_param.nil?

    response = RestClient::Request.execute(
      method: :get, url: 'https://api.giphy.com/v1/gifs/search',
      headers: {
        params: {
          api_key: ENV["GIPHY_API_KEY"],
          q: search_param,
          limit: 10,
          rating: 'g'
        }
      }
    )
    body = JSON.parse(response.body)
    render json: body['data']
  end
end
