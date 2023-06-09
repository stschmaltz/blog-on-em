class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      create_user_session(user)
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    user_sign_out
    redirect_to posts_url, notice: 'Logged out successfully'
  end

  private

  def create_user_session(user)
    session[:user_id] = user.id

    redirect_to((session[:intended_url] || user), notice: 'Logged in successfully')
    session[:intended_url] = nil
  end
end
