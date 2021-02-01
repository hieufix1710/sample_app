class PasswordResetsController < ApplicationController
  before_action :load_user, except: [:new, :create]

  def new
  end

  def edit
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t"email_send password_reset_instructions"
      redirect_to root_url
    else
      flash.now[:danger] = t"email_address_not_found"
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
    return if @user
  end
end
