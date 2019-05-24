class AuthController < ApplicationController
	def sign_up
		RestClient.post('http://localhost:3001/create', { login: params[:login], 
														  password: params[:password] } ) { |response, request, result|
			@r = response
		}
		render json: @r
	end

	def log_in
		RestClient.post('http://localhost:3001/auth', { login: params[:login], 
														  password: params[:password] } ) { |response, request, result|
			@r = JSON.parse(response).with_indifferent_access
		}
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
