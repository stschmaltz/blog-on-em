class UsersController < ApplicationController
  before_action :require_sign_in, except: %i[new create]
  before_action :require_correct_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def show
    @user = find_user_by_id
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Account created successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Account updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    user_sign_out

    redirect_to posts_url, notice: 'Account deleted successfully'
  end

  private

  def require_correct_user
    @user = find_user_by_id
    return if current_user?(@user)

    redirect_to root_url, alert: 'Unauthorized to perform this action'
  end

  def find_user_by_id
    User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
