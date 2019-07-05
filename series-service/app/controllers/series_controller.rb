class SeriesController < ApplicationController
	skip_before_action :verify_authenticity_token
	@@key = "my_super_secure_key"

	before_action :set_token, except: [:read, :index]

	def index
		render json: Series.all
	end

	def set_token
		@token = JWT.decode(params[:token], @@key, true, { algorithm: 'HS256' })[0]
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
		##res['content'].gsub!(/(?:\n\r?|\r\n?)/, '<br>');
		res.update( { user_id: @user_id, login: @login } )
		res.except!('token', 'controller', 'action')
	end

	def create
		@series = Series.new(params_for_create)
		if @series.save
			render json: { user_id: @user_id,
					  	   name: params[:name],
					 	   avatar_id: params[:avatar_id],
						   status: "Ok" }
		else
			render json: { status: "New series was not created",
						   error: "Invalid series parameters" }
    	end
	end

	def read
		if @series = Series.find_by(id: params[:id])
			render json: { series_id: @article.series_id,
						   name: @article.name,
						   content: @article.content,
						   status: "Ok" }
    	else
    		render json: { status: "Series was not read",
    					   error: "Series record with given login not found" }
    	end
	end

	def update
		if @series = Series.find_by(id: params[:id])
			if @series.user_id == @user_id
				if @series.update(params_for_update)
					render json: { status: 'Ok' }
				else
					render json: { status: "Series was not updated",
								   error: "Invalid series parameters" }
				end
			else
				render json: { status: "Series was not updated", 
							   error: "Provided token doesn't belong to series's owner" }
    		end
    	else
    		render json: { status: "Series was not updated",
    					   error: "Series record with given id not found" }
    	end
	end

	def delete
		if @series = Series.find_by(id: params[:id])
			if @series.user_id == @user_id
				@series.destroy
				render json: { status: "Ok" }
			else
				render json: { status: "Series was not deleted",
							   error: "Provided token doesn't belong to series's owner" }
    		end
    	else
    		render json: { status: "Series was not deleted", 
    					   error: "Series record with given id not found" }
    	end
	end

	def profile_params
		params.permit(:token, :id, :name, :avatar_id, :login)
	end
end
