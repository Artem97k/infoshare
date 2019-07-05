class SeriesController < ApplicationController
	@@service_url = 'http://localhost:3004/'

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
		RestClient.post(@@service_url + 'delete',
						{ token: params[:token],
						  id: params[:id] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end
end
