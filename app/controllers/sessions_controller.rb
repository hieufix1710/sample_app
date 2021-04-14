class SessionsController < ApplicationController
  before_action :load_user, only: %i(create)

  def new
    @user = User.new
  end

  def load_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end

  def create
    if @user.try(:authenticate, params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message = t "account_not_activated_check_your_email_for_the_activation_link"
        flash.now[:warning] = message
        render :new
      end
    else
      flash[:warning] = t "invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
