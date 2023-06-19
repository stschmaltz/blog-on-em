module ApplicationHelper
  def current_user
    user_id = session[:user_id]
    User.find_by(id: user_id) if user_id
  end

  def sign_out
    session[:user_id] = nil
  end
end
