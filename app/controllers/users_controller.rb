class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :find_user

  def edit; end

  def update
    @user.update(user_params)

    redirect_to user_path(@user)
  end

  def index
    @users = User.all
  end

  def show
  end

  private

  def find_user
    @user = current_user
  end

  def find_selected_user
    @selected_user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
