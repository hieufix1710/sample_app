class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_user

  def new
    @user = User.new
  end

  def load_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end

  def create
    if @user&.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      redirect_to @user
      flash[:success] = t "hello_user", user: @user.name
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
