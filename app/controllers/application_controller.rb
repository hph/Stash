class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  after_action :store_location

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  def store_location
    ignored_pages = [new_user_session_path, new_user_registration_path]
    unless ignored_pages.any? { |p| request.path.include?(p) } || request.xhr?
      session[:previous_path] = request.fullpath if request.get?
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_path] || home_path
  end
end
