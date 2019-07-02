class ArticlesController < ApplicationController
	@@key = "my_super_secure_key"

	before_action :set_token, except: [:read, :index, :find]

	def index
		render json: Article.all
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
		res.update( { user_id: @user_id } )
		res.except!('token', 'controller', 'action')
	end

	def create
		@article = Article.new(params_for_create)
		if @article.save
			render json: { user_id: @user_id,
						   series_id: params[:series_id],
					  	   name: params[:name],
					  	   content: params[:content],
						   status: "Ok" }
		else
			render json: { status: "New article was not created",
						   error: "Invalid article parameters" }
   		end
	end

	def read
		if @article = Article.find_by(id: params[:id])
			render json: { series_id: params[:series_id],
						   name: params[:name],
						   content: params[:content],
						   status: "Ok" }
    	else
    		render json: { status: "Article was not read",
    					   error: "Article record with given id not found" }
    	end
	end

	def update
		if @article = Article.find_by(id: params[:id])
			if @article.user_id == @user_id
				if @article.update(params_for_update)
					render json: { status: 'Ok' }
				else
					render json: { status: "Article was not updated",
								   error: "Invalid article parameters" }
				end
			else
				render json: { status: "Article was not updated", 
							   error: "Provided token doesn't belong to article's owner" }
    		end
    	else
    		render json: { status: "Article was not updated",
    					   error: "Article record with given id not found" }
    	end
	end

	def delete
		if @article = Article.find_by(id: params[:id])
			if @article.user_id == @user_id
				@article.destroy
				render json: { status: "Ok" }
			else
				render json: { status: "Article was not deleted",
							   error: "Provided token doesn't belong to article's owner" }
    		end
    	else
    		render json: { status: "Profile was not deleted", 
    					   error: "Profile record with given id not found" }
    	end
	end

	def find
      @db = Article.all
      @db = @db.as_json
      @res = Array.new
      @db.each do |profile|
      if ( article['content'].include?(params[:query]) || 
      		article['name'].include?(params[:query]) ) then @res.push(article) end
      end
      if @res.any? then
      	@res.push( { status: "Ok" } )
      else
      	@res.push( { status: "Nothing found!" } )
      end
      render json: @res
	end

	def profile_params
		params.permit(:token, :id, :series_id, :name, :content, :query )
	end
end
