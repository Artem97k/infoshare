class UsersController < ApplicationController
	include BCrypt
	def index
		render json: User.all
	end

	def read
		@user = User.find_by(login: params[:login])
		if @user.password == params[:password]
			render json: { pwd: @user.password, token: @user.issue_token, decoded_token: @user.decode_token, status: "ok" }
		else
			render json: { status: "not ok" }
		end
	end

	def create
		@user = User.new(login: params[:login], password: params[:password])
		if @user.save
			render json: { login: @user.login, pwd: @user.password, created: @user.created_at, token: @user.issue_token, decoded_token: @user.decode_token }
		else
			render json: { errors: "Invalid user parameters" }
    	end
	end

	def update
		if @user = User.find_by(login: params[:login])
			if @user.password == params[:password]
				if @user.update(login: params[:login], password: params[:new_password])
					render json: { status: 'Updated succesfully' }
				else
					render json: { status: 'Invalid user parameters'}
				end
			else
				render json: { status: "Can't update, wrong password" }
    		end
    	else
    		render json: { status: "Can't find user" }
    	end
	end

	def delete
		if @user = User.find_by(login: params[:login])
			if @user.password == params[:password]
				@user.destroy
			else
				render json: { status: "Can't delete, wrong password" }
    		end
    	else
    		render json: { status: "Can't find user" }
    	end
	end

	def user_params
		params.require(:user).permit(:login, :password, :new_password)
	end
end
