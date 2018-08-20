class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
# protected adds another layer of protection

protected
	def configure_permitted_parameters
		# allow these extra things for the sign up action
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :bio, :location, :avatar, :following])
		# allow these extra things for the account update action
		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username, :bio, :location, :avatar, :following])
	end	
end
