class CommentController < ApplicationController
	before_action :set_service_url

	def set_service_url
		@service_url = 'http://localhost:3005/'
	end

	def create
		RestClient.post(@service_url + 'create',
						{ token: session[:token],
						  article_id: params[:article_id],
						  parent_id: params[:parent_id],
						  content: params[:content],
						  name: params[:name],
						  surname: params[:surname],
						  avatar_id: params[:avatar_id] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def read
		RestClient.get(@service_url + 'read?' + "id=#{params[:id]}" ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def update
		RestClient.put(@service_url + 'update',
						{ token: session[:token],
						  content: params[:content] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def delete
		RestClient.post(@service_url + 'delete',
						{ token: session[:token],
						  id: params[:id] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end
end
