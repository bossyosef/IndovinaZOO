class AdminUser::ParameterSanitizer < Devise::ParameterSanitizer
	private
	
	def sign_in
		default_params.permit(auth_keys)
	end
	
	def sign_up
		default_params.permit(auth_keys + [:password, :password_confirmation, :name, :surname, :email])	
	end
	
	def	account_update
		default_params.permit(auth_keys + [:password, :password_confirmation, :current_password, :name, :surname, :email])
	end
end
