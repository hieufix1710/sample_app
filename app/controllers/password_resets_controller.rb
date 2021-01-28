class PasswordResetsController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  def new
  end

  def edit
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render :new
    end
  end

  def update
    if user_params[:password].empty?

    elsif @user.update user_params
      redirect_to login_path
      flash[:success] = t("update_success")

    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email].downcase
  end
end
