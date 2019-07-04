class ArticlesController < ApplicationController
	@@key = "my_super_secure_key"

	before_action :set_token, except: [:read, :index, :find, :read_by_author, :read_by_category]

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
		##res['content'].gsub!(/(?:\n\r?|\r\n?)/, '<br>');
		res.update( { user_id: @user_id, login: @login } )
		res.except!('token', 'controller', 'action')
	end

	def create
		@article = Article.new(params_for_create)
		if @article.save
			render json: { user_id: @user_id,
						   login: @login,
						   series_id: params[:series_id],
					  	   name: params[:name],
					  	   content: params[:content],
					  	   category: params[:category],
						   status: "Ok" }
		else
			render json: { status: "New article was not created",
						   error: "Invalid article parameters" }
   		end
	end

	def read
		if @article = Article.find_by(id: params[:id])
			render json: { id: @article.id,
				           login: @article.login,
				           series_id: @article.series_id,
						   name: @article.name,
						   content: @article.content,
						   category: @article.category,
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
    		render json: { status: "Article was not deleted", 
    					   error: "Article record with given id not found" }
    	end
	end

	def read_by_author
		@articles = Article.where(user_id: params[:user_id])
		if @articles.any?
			@articles = @articles.as_json
			@res = Array.new
			@articles.each do |article|
				@res.push(article)
			end
			@res.push( { status: "Ok" } )
			render json: @res
    	else
    		render json: { status: "Article was not read",
    					   error: "Article record with given author id not found" }
    	end
	end

	def read_by_category
		@articles = Article.where(category: params[:category])
		if @articles.any?
			@articles = @articles.as_json
			@res = Array.new
			@articles.each do |article|
				@res.push(article)
			end
			@res.push( { status: "Ok" } )
			render json: @res
    	else
    		render json: { status: "Article was not read",
    					   error: "Article record with given category not found" }
    	end
	end

	def find
      @db = Article.all
      @db = @db.as_json
      @res = Array.new
      @db.each do |article|
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
		params.permit(:token, :id, :series_id, :name, :content, :query, :category, :user_id )
	end
end
