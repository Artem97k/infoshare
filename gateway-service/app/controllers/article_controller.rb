class ArticleController < ApplicationController
		before_action :set_auth_url

	def set_auth_url
		@service_url = 'http://localhost:3003/'
	end

	def create
		RestClient.post(@service_url + 'create',
						{ token: session[:token],
						  series_id: params[:series_id],
						  name: params[:name],
						  content: params[:content] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def read
		RestClient.get(@service_url + 'read?' + "article_id=#{params[:article_id]}" ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def update
		RestClient.put(@service_url + 'update',
						{ token: session[:token],
						  series_id: params[:series_id],
						  name: params[:name],
						  content: params[:content] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def delete
		RestClient.post(@service_url + 'delete',
						{ token: session[:token],
						  article_id: params[:article_id] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end
end
