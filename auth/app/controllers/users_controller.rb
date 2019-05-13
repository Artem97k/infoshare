class UsersController < ApplicationController
	include BCrypt
	def showall
		render json: User.all
	end

	def showmatch
		@user = User.find_by(login: params[:login])
		if @user.password == params[:password]
			render json: { status: "ok" }
		else
			render json: { status: "not ok"}
		end
	end

	def create
		@user = User.new(login: params[:login], password: params[:password])
		if @user.save
			render json: { login: @user.login, pwd: @user.password, created: @user.created_at, token: @user.issue_token, decoded_token: @user.decode_token }
		else
			render json: { errors: "Can't create new user" }
    	end
	end

	def update
	end

	def delete
	end

	def user_params
    	params.permit(
     	 :login, :password
    	)
	end
end
