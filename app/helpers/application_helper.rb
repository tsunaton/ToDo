module ApplicationHelper

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def log_in?
    !@current_user.nil?
  end
end
