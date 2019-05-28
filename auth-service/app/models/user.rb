class User < ApplicationRecord
	include BCrypt
	@@key = "my_super_secure_key"

	validates :login, :presence => true, :length => { :in => 5..20 }, :uniqueness => true

	def password=(password)
		@password = Password.create(password)
		self.hashed_pwd = @password
	end

	def password
		@password ||= Password.new(self.hashed_pwd)
	end

	def issue_token
		JWT.encode(self.login, @@key, 'HS256')
	end

	def decode_token
		JWT.decode(self.issue_token, @@key, true, { algorithm: 'HS256' })[0]
	end
end
