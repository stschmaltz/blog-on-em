class ApplicationController < ActionController::Base
  private

  def user_sign_out
    session[:user_id] = nil
  end

  def current_user
    user_id = session[:user_id]
    User.find_by(id: user_id) if user_id
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def require_sign_in
    return if current_user

    session[:intended_url] = request.url
    redirect_to new_session_path, alert: 'Please sign in first'
  end

  def require_admin
    return if current_user_admin?

    redirect_to root_url, alert: 'Unauthorized to perform this action'
  end

  def current_user_admin?
    current_user&.admin?
  end

  helper_method :current_user_admin?
end
