class SeriesController < ApplicationController
	@@service_url = @@series_url

	def create
		RestClient.post(@@service_url + 'create',
						{ token: params[:token],
						  name: params[:name],
						  avatar_id: params[:avatar_id] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def read
		RestClient.get(@@service_url + 'read?' + "id=#{params[:id]}" ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def read_by_author
		RestClient.post(@@service_url + 'read_by_author', { user_id: params[:user_id] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def update
		RestClient.put(@@service_url + 'update',
						{ token: params[:token],
						  name: params[:name],
						  avatar_id: params[:avatar_id] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def delete
		RestClient.post(@@article_url + 'delete_by_series',
						{ token: params[:token],
						  series_id: params[:id] } ) do |response, request, result|
			@r1 = response
		end
		RestClient.post(@@service_url + 'delete',
						{ token: params[:token],
						  id: params[:id] } ) do |response, request, result|
			@r2 = response
		end
		render json:  [ JSON.parse(@r1), JSON.parse(@r2) ]
	end
end
