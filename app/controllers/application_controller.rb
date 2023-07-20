class ApplicationController < ActionController::API
  include ActiveSupport::Rescuable
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :exception

  rescue_from StandardError, with: :render_internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_internal_server_error(_exception)
    render json: { error: 'Internal Server Error' }, status: :internal_server_error
  end

  def render_not_found(_exception)
    render json: { error: 'Not Found' }, status: :not_found

  def current_user
    User.first
  end
end
