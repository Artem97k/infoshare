class ArticlesController < ApplicationController
	skip_before_action :verify_authenticity_token
	@@key = "my_super_secure_key"

	before_action :set_token, except: [:read, :index]

	def index
		render json: Article.all
	end

	def set_token
		@token = JWT.decode(params[:token], @@key, true, { algorithm: 'HS256' })[0]
		rescue StandardError => @error
		if @error
			render json: { status: 'Could not decode token, please reauthoirize', 
						   error: @error }
		else
			@login = @token['login']
			@user_id = @token['id']
		end
	end

	def create
		@article = Article.new( user_id: @user_id
								series_id: params[:series_id],
					  			name: params[:name],
					 			content: params[:content] )
		if @article.save
			render json: { user_id: @user_id
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
			render json: { series_id: @article.series_id,
						   name: @article.name,
						   content: @article.content,
						   status: "Ok" }
    	else
    		render json: { status: "Article was not read",
    					   error: "Article record with given id not found" }
    	end
	end

	def update
		if @article = Article.find_by(id: params[:id])
			if @article.user_id == @user_id
				if @article.update( series_id: params[:series_id],
									name: params[:name],
									content: params[:content] )
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

	def profile_params
		params.permit(:token, :id, :series_id, :name, :content )
	end
end
