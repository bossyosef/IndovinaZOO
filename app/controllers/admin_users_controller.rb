class AdminUsersController < ApplicationController
	before_filter :authenticate_admin_user!	
			
	def index
		respond_to do |format|
			format.html
		end
	end
end
