class ProfilesController < ApplicationController
	skip_before_action :verify_authenticity_token
	@@key = "my_super_secure_key"

	before_action :set_token, except: [:read, :index, :find]

	def index
		render json: Profile.all
	end

	def set_token
		@token = JWT.decode(params['token'], @@key, true, { algorithm: 'HS256' })[0]
		@login = @token['login']
		@user_id = @token['id']
	end

	def params_for_update
		res = Hash.new
		params.each { |key, value| if value != nil then res[key] = value end }
		res.except!('token', 'controller', 'action')
	end

	def params_for_create
		res = Hash.new
		params.each { |key, value| if value != nil then res[key] = value end }
		res.update( { login: @login, user_id: @user_id } )
		res.except!('token', 'controller', 'action')
	end
	
	def create
		@profile = Profile.new(params_for_create)
		if @profile.save
			render json: { user_id: @profile.user_id,
				           login: @profile.login,
						   name: @profile.name,
						   surname: @profile.surname, 
						   email: @profile.email, 
						   bio: @profile.bio,
						   avatar_id: @profile.avatar_id,
						   status: "Ok" }
		else
			render json: { status: "New profile was not created",
						   error: "Invalid profile parameters", }
    	end
	end

	def read
		if @profile = Profile.find_by(login: params[:login])
			render json: { user_id: @profile.user_id,
				           login: @profile.login, 
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
		if @profile = Profile.find_by(user_id: @user_id)
			if @profile.user_id == @user_id
				if @profile.update(params_for_update)
					render json: { user_id: @profile.user_id,
								   login: @profile.login,
								   name: @profile.name, 
						    	   surname: @profile.surname,
						   		   email: @profile.email, 
						   		   bio: @profile.bio,
						   		   avatar_id: @profile.avatar_id,
						   		   status: 'Ok' }
				else
					render json: { status: "Profile was not updated",
								   error: "Invalid profile parameters" }
				end
			else
				render json: { status: "Profile was not updated", 
							   error: "Provided token doesn't belong to profile's owner" }
			end
    	else
    		render json: { status: "Profile was not updated",
    					   error: "Profile record with given id not found" }
    	end
	end

	def delete
		if @profile = Profile.find_by(user_id: @user_id)
			if @profile.user_id == @user_id
				@profile.destroy
				render json: { status: "Ok" }
			else
				render json: { status: "Profile was not deleted",
							   error: "Provided token doesn't belong to profile's owner" }
			end
    	else
    		render json: { status: "Profile was not deleted", 
    					   error: "Profile record with given id not found" }
    	end
	end

	def find
      @db = Profile.all
      @db = @db.as_json
      @res = Array.new
      @db.each do |profile|
      if ( profile['login'].include?(params[:query]) || 
      		profile['name'].include?(params[:query]) || 
      		profile['surname'].include?(params[:query]) ) then @res.push(profile) end
      end
      if @res.any? then
      	@res.push( { status: "Ok" } )
      else
      	@res.push( { status: "Nothing found!" } )
      end
      render json: @res
	end

	def profile_params
		params.permit(:login, :name, :surname, :email, :bio, :avatar_id, :token, :user_id, :query)
	end
end
