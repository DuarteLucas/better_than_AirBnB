class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
