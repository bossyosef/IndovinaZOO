class AdminUsers::RegistrationsController < Devise::RegistrationsController
	skip_before_filter :require_no_authentication
	
	def create
		super
	end
	
	protected
	
	def sign_up(resource_name, resource)
		true
	end
end
