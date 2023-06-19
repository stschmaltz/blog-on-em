class ApplicationController < ActionController::Base
  def user_sign_out
    session[:user_id] = nil
  end
end
