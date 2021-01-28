class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token


  def new
    @user = User.new
  end

  def load_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end

  def create
    load_user
    if @user.try(:authenticate, params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message = "Account not activated. Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
end
    else
      flash[:warning] = t "invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
