class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      redirect_to user
      flash[:success] = t "hello_user", user: user.name
    else
      flash.now[:warning] = t "invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
