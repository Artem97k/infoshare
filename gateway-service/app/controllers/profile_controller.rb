class ProfileController < ApplicationController
	@@service_url = @@profile_url

	def create
		RestClient.post(@@service_url + 'create',
						{ token: params[:token],
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
		RestClient.get(@@service_url + 'read?' + "login=#{params[:login]}" ) do |response, request, result|
			@r = response
		end
		render json: @r
	end

	def update
		RestClient.put(@@service_url + 'update',
						{ token: params[:token],
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
		RestClient.post(@@service_url + 'delete',
						{ token: params[:token],
						  login: params[:login] } ) do |response, request, result|
			@r = response
		end
		render json: @r
	end
end
