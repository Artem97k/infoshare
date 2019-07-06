class SeriesController < ApplicationController
	@@key = "my_super_secure_key"
	@@gate_url = 'http://localhost:3000/'

	before_action :set_token, except: [:read, :index, :read_by_author, :find]

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
			render json: { id: @series.id,
				           user_id: @series.user_id,
						   login: @series.login,
					  	   name: @series.name,
					 	   avatar_id: @series.avatar_id,
						   status: "Ok" }
		else
			render json: { status: "New series was not created",
						   error: "Invalid series parameters" }
    	end
	end

	def read
		if @series = Series.find_by(id: params[:id])
			render json: { user_id: @series.user_id,
						   login: @series.login,
						   id: @series.id,
						   name: @series.name,
						   avatar_id: @series.avatar_id,
						   status: "Ok" }
    	else
    		render json: { status: "Series was not read",
    					   error: "Series record with given login not found" }
    	end
	end

	def read_by_author
		@series = Series.where(user_id: params[:user_id])
		if @series.any?
			@series = @series.as_json
			@res = Array.new
			@series.each do |series|
				@res.push(series)
			end
			@res.push( { status: "Ok" } )
			render json: @res
    	else
    		render json: { status: "Series was not read",
    					   error: "Series record with given author id not found" }
    	end
	end

	def update
		if @series = Series.find_by(id: params[:id])
			if @series.user_id == @user_id
				if @series.update(params_for_update)
					render json: { series_id: @series.id,
						           login: @series.login,
						   		   name: @series.name,
								   avatar_id: @series.avatar_id,
								   status: 'Ok' }
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

	def find
      @db = Series.all
      @db = @db.as_json
      @res = Array.new
      @db.each do |series|
        if ( series['name'].include?(params[:query]) ) then @res.push(series) end
      end
      if @res.any? then
      	@res.push( { status: "Ok" } )
      else
      	@res.push( { status: "Nothing found!" } )
      end
      render json: @res
	end

	def profile_params
		params.permit(:token, :id, :name, :avatar_id, :login, :query)
	end
end
