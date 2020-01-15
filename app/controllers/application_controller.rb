class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	rescue_from CanCan::AccessDenied do |exception|
	  flash[:alert] = "You are not authorized for this action"
	  redirect_to root_path
	end

  protected

  def configure_permitted_parameters
    attributes = [:name, :email, :role]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end
