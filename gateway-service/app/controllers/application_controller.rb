class ApplicationController < ActionController::API
	def root
	end
	@@auth_url = 'http://localhost:3001/'
	@@profile_url = 'http://localhost:3002/'
	@@article_url = 'http://localhost:3003/'
	@@series_url = 'http://localhost:3004/'
end
