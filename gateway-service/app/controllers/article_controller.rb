class ArticleController < ApplicationController
	@@service_url = @@article_url

	def create
		RestClient.post(@@service_url + 'create',
						{ token: params[:token],
						  series_id: params[:series_id],
						  name: params[:name],
						  content: params[:content],
						  category: params[:category] } ) do |response, request, result|
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

	def read_by_category
		RestClient.post(@@service_url + 'read_by_category', { category: params[:category] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def read_by_series
		RestClient.post(@@service_url + 'read_by_series', { series_id: params[:series_id] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def update
		RestClient.put(@@service_url + 'update',
						{ token: params[:token],
						  id: params[:id],
						  series_id: params[:series_id],
						  name: params[:name],
						  content: params[:content],
						  category: params[:category] } ) do |response, request, result|
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
