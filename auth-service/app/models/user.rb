class User < ApplicationRecord
	include BCrypt
	@@key = "my_super_secure_key"

	validates :login, :presence => true, :length => { :in => 3..20 }, :uniqueness => true
	validates :password, :presence => true

	def password=(password)
		@password = Password.create(password)
		self.hashed_pwd = @password
	end

	def password
		@password ||= Password.new(self.hashed_pwd)
	end
	
	def issue_token
		JWT.encode({ 'login': self.login, 'id': self.id }, @@key, 'HS256')
	end

	def decode_token
		JWT.decode(self.issue_token, @@key, true, { algorithm: 'HS256' })[0]
	end
end
