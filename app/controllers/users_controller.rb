class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @user = User.find_by id: params[:id]
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
      flash[:success] = t "Welcome_to_the_sample_app!"
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end
end
