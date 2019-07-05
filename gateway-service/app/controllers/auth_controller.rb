class AuthController < ApplicationController
	@@service_url = @@auth_url

	def sign_up
		RestClient.post( @@service_url + 'create', 
						{ login: params[:login],
						  password: params[:password] } ) do |response, request, result|
			@r = JSON.parse(response).with_indifferent_access
		end
		render json: @r
	end

	def log_in
		RestClient.post( @@service_url + 'auth',
						{ login: params[:login], 
						  password: params[:password] } ) do |response, request, result|
			@r = JSON.parse(response).with_indifferent_access
		end
		if @r[:status] == 'Ok'
			render json: { status: 'Ok',
						   token: @r[:token],
						   login: params[:login],
						   user_id: @r[:user_id] }
		else
			render json: { status: @r[:status], error: @r[:error] }
		end
	end
	
	def log_out
		if session[:token]
			session[:token] = nil
			render json: { status: 'Ok' }
		else
			render json: { status: 'Could not log out',
						   error: 'No session to terminate' }
		end
	end
end
