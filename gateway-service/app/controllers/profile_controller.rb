class ProfileController < ApplicationController
	before_action :set_service_url

	def set_service_url
		@service_url = 'http://localhost:3002/'
	end

	def create
		RestClient.post(@service_url + 'create',
						{ token: session[:token],
						  login: params[:login],
						  name: params[:name],
						  surname: params[:surname],
						  email: params[:email],
						  bio: params[:bio],
						  avatar_id: params[:avatar_id] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def read
		RestClient.get(@service_url + 'read?' + "login=#{params[:login]}" ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def update
		RestClient.put(@service_url + 'update',
						{ token: session[:token],
						  login: params[:login],
						  name: params[:name],
						  surname: params[:surname],
						  email: params[:email],
						  bio: params[:bio],
						  avatar_id: params[:avatar_id] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def delete
		RestClient.post(@service_url + 'delete',
						{ token: session[:token],
						  login: params[:login] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end
end
