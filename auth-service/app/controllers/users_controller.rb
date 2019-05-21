class UsersController < ApplicationController
	def index
		render json: User.all
	end

	def create
		@user = User.new(login: params[:login], password: params[:password])
		if @user.save
			render json: { id: @user.id, login: @user.login, pwd: @user.password, created: @user.created_at, status: "Ok" }
		else
			render json: { status: "New user was not created", error: "Invalid user parameters" }
    	end
	end

	def read
		if @user = User.find_by(login: params[:login])
			if @user.password == params[:password]
				render json: { login: @user.login, created: @user.created_at, status: "Ok" }
			else
				render json: { status: "User was not read", error: "Incorrect password" }
    		end
    	else
    		render json: { status: "User was not read", error: "User record with given login not found" }
    	end
	end

	def update
		if @user = User.find_by(login: params[:login])
			if @user.password == params[:password]
				if @user.update(login: params[:login], password: params[:new_password])
					render json: { status: 'Ok' }
				else
					render json: { status: "User was not updated", error: "Invalid user parameters" }
				end
			else
				render json: { status: "User was not updated", error: "Incorrect password" }
    		end
    	else
    		render json: { status: "User was not updated", error: "User record with given login not found" }
    	end
	end

	def delete
		if @user = User.find_by(login: params[:login])
			if @user.password == params[:password]
				@user.destroy
				render json: { status: 'Ok' }
			else
				render json: { status: "User was not deleted", error: "Incorrect password" }
    		end
    	else
    		render json: { status: "User was not deleted", error: "User record with given login not found" }
    	end
	end

	def auth
		if @user = User.find_by(login: params[:login])
			if @user.password == params[:password]
				render json: @user.issue_token
			else
				render json: { status: "Can't authorize client", error: "Incorrect password" }
    		end
    	else
    		render json: { status: "Can't authorize client", error: "User record with given login not found" }
    	end
	end

	def user_params
		params.require(:user).permit(:login, :password, :new_password)
	end
end
