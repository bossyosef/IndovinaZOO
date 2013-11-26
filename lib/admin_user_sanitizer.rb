class AdminUser::ParameterSanitizer < Devise::ParameterSanitizer
	private
	def account_update
		default_params.permit(:username, :email, :fullname, :password, :password_confirmation, :current_password)
	end
	
	private
	def sign_in
		default_params.permit(:username, :password)
	end
	
	private
	def sign_up
		default_params.permit(:username, :email, :fullname, :password, :password_confirmation, :current_password)
	end
end
