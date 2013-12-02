class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def devise_parameter_sanitizer
	if resource_class == AdminUser
		AdminUser::ParameterSanitizer.new(AdminUser, :admin_user, params)
	else
		super
	end
  end
  
  #Metodo di devise sovrascritto per memorizzare la pagina di provenienza.
  def store_location
	if(!request.fullpath.match("/admin_users/") &&
	   !request.xhr? && (request.format == "text/html" || request.content_type == "text/html")) #per le chiamate ajax
	   session[:previous_url] = request.fullpath
	   session[:last_request_time] = Time.now_utc_to_i
	end
  end
  
  #Metodo che sovrascrive la procedura di redirezione dopo il login
  def after_sign_in_path_for(resource)
	 session[:previous_url] || root_path
  end
end
