class ProfilesController < ApplicationController
	@@key = "my_super_secure_key"

	def create
		@profile = Profile.new( login: params[:login], 
						   		name: params[:name], 
						   		surname: params[:surname], 
						   		email: params[:email], 
						   		bio: params[:bio] )
		if @profile.save
			render json: { login: @profile.login,
						   name: @profile.name, 
						   surname: @profile.surname, 
						   email: @profile.email, 
						   bio: @profile.bio,
						   status: "Ok" }
		else
			render json: { status: "New profile was not created",
						   error: "Invalid profile parameters" }
    	end
	end

	def read
		if @profile = Profile.find_by(login: params[:login])
			render json: { login: @profile.login, 
						   name: @profile.name, 
						   surname: @profile.surname, 
						   email: @profile.email, 
						   bio: @profile.bio,
						   avatar_id: @profile.avatar_id,
						   status: "Ok" }
    	else
    		render json: { status: "Profile was not read",
    					   error: "Profile record with given login not found" }
    	end
	end

	def update
		@login = JWT.decode(params[:token], @@key, true, { algorithm: 'HS256' })[0]
		rescue StandardError => error

		if @profile = Profile.find_by(login: @login)
			if @profile.login == @login
				if @profile.update( name: params[:name], 
						   			surname: params[:surname], 
						   			email: params[:email], 
						   			bio: params[:bio],
						   			avatar_id: params[:avatar_id] )
					render json: { status: 'Ok' }
				else
					render json: { status: "Profile was not updated",
								   error: "Invalid profile parameters" }
				end
			else
				render json: { status: "Profile was not updated", 
							   error: "Provided JWT doesn't belong to profile's owner" }
    		end
    	else
    		render json: { status: "Profile was not updated",
    					   error: "Profile record with given login not found" }
    	end
	end

	def delete
		@login = JWT.decode(params[:token], @@key, true, { algorithm: 'HS256' })[0]
		rescue StandardError => error

		if @profile = Profile.find_by(login: @login)
			if @profile.login == @login
				@profile.destroy
				render json: { status: "Ok" }
			else
				render json: { status: "Profile was not deleted",
							   error: "Provided JWT doesn't belong to profile's owner" }
    		end
    	else
    		render json: { status: "Profile was not deleted", 
    					   error: "Profile record with given login not found" }
    	end
	end

	def profile_params
		params.require(:login).permit(:token, :login, :name, :surname, :email, :bio, :avatar_id)
	end
end
