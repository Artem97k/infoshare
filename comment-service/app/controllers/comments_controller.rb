class CommentsController < ApplicationController
	skip_before_action :verify_authenticity_token
	@@key = "my_super_secure_key"

	before_action :set_token, except: [:read, :index]

	def index
		render json: Comment.all
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
		@comment = Comment.new( article_id: params[:article_id],
								user_id: @user_id,
								parent_id: params[:parent_id],
								content: params[:content],
								name: params[:name],
								surname: params[:surname],
								avatar_id: params[:avatar_id] )
		if @comment.save
			render json: { article_id: params[:article_id],
						   user_id: @user_id,
						   parent_id: params[:parent_id],
						   content: params[:content],
						   name: params[:name],
						   surname: params[:surname],
						   avatar_id: params[:avatar_id],
						   status: "Ok" }
		else
			render json: { status: "New comment was not created",
						   error: "Invalid comment parameters" }
   		end
	end

	def read
		if @comment = Comment.find_by(id: params[:id])
			render json: { article_id: params[:article_id],
						   user_id: @user_id,
						   parent_id: params[:parent_id],
						   content: params[:content],
						   name: params[:name],
						   surname: params[:surname],
						   avatar_id: params[:avatar_id],
						   status: "Ok" }
    	else
    		render json: { status: "Comment was not read",
    					   error: "Comment record with given id not found" }
    	end
	end

	def update
		if @comment = Comment.find_by(id: params[:id])
			if @comment.user_id == @user_id
				if @comment.update( content: params[:content] )
					render json: { status: 'Ok' }
				else
					render json: { status: "Comment was not updated",
								   error: "Invalid comment parameters" }
				end
			else
				render json: { status: "Comment was not updated", 
							   error: "Provided token doesn't belong to comment's owner" }
    		end
    	else
    		render json: { status: "Comment was not updated",
    					   error: "Comment record with given id not found" }
    	end
	end

	def delete
		if @comment = Comment.find_by(id: params[:id])
			if @comment.user_id == @user_id
				@comment.destroy
				render json: { status: "Ok" }
			else
				render json: { status: "Comment was not deleted",
							   error: "Provided token doesn't belong to comment's owner" }
    		end
    	else
    		render json: { status: "Comment was not deleted", 
    					   error: "Comment record with given id not found" }
    	end
	end

	def profile_params
		params.permit(:token, :id, :article_id, :user_id, :parent_id, :content, :name, :surname, :avatar_id )
	end
end
