class UsersController < ApplicationController
  before_action :load_user

  def show
    @user = User.find_by id: params[:id]
    return if @user

    render :new
    flash.now[:error] = t "user_not_exists"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      remember @user
      redirect_to @user
      flash[:success] = t "welcome_to_the_sample_app!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash.now[:danger] = t "user_not_found"
  end
end
