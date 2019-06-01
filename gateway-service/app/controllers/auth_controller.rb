class AuthController < ApplicationController
	before_action :set_service_url

	def set_service_url
		@service_url = 'http://localhost:3001/'
	end

	def sign_up
		RestClient.post( @service_url + 'create', 
						{ login: params[:login],
						  password: params[:password] } ) do |response, request, result|
			@r = JSON.parse(response).with_indifferent_access
		end
		render json: @r
	end

	def log_in
		RestClient.post( @service_url + 'auth',
						{ login: params[:login], 
						  password: params[:password] } ) do |response, request, result|
			@r = JSON.parse(response).with_indifferent_access
		end
		if @r[:status] == "Ok"
			session[:token] = @r[:token]
			render json: { status: 'Ok',
						   token: @r[:token],
						   session: session[:token] }
		else
			render json: { status: @r[:status], error: @r[:error] }
		end
	end
	
	def log_out
		if session[:token]
			session[:token] = nil
			render json: { status: 'Ok',
						   session: session[:token] }
		else
			render json: { status: 'Could not log out',
						   error: 'No session to terminate',
						   session: session[:token] }
		end
	end
end
