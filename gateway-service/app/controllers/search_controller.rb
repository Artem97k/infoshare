class SearchController < ApplicationController
  before_action :set_url
  def set_url
    case params[:type]
      when "profile"
        @url = 'http://localhost:3002/find?' 
      when "article"
      	@url = 'http://localhost:3003/find?'
      when "series"
      	@url = 'http://localhost:3004/find?'
    end
  end

  def find
  	RestClient.post(@url, { query: params[:query] } ) do |response, request, result|
			@r = response
		end
	render json: @r
  end
end
