class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def load_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user.try(:authenticate, params[:session][:password])
      log_in user
      remember user
      redirect_to user
    else
      flash.now[:danger] = t "invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
