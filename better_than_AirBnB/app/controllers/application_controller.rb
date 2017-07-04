class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: protected
  alias_method :current_user, :current_member
  # Pundit uses user, we changed it to member

  rescue_from Pundit::NotAuthorizedError, with: :member_not_authorized
  private

  def member_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
