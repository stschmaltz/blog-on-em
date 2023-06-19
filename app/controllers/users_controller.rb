class UsersController < ApplicationController
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
      redirect_to @user, notice: 'Account created successfully'
    else
      render :new
    end
  end

  def edit
    @user = find_user_by_id
  end

  def update
    @user = find_user_by_id

    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Account updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @user = find_user_by_id
    @user.destroy

    user_sign_out

    redirect_to posts_url, alert: 'Account deleted successfully'
  end

  private

  def find_user_by_id
    User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
