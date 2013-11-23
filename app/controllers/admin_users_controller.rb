class AdminUsersController < InheritedResources::Base
	before_filter :authenticate_admin_user!
	
	respond_to :html, :json
	actions :all
		
end
