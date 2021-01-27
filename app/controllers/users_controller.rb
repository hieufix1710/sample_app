class UsersController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :correct_user, only: [:edit, :update]

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  def current_user?(user)
    user == current_user
  end
  def show
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:warning] =  t 'not_found'
    end
  end
  def index
    @users = User.paginate(page: params[:page])
  end
  def new
    @user = User.new
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = t"deleted"
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = t "Welcome_to_the_sample_app!"
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:success] =  t "update"
      redirect_to @user
    else
      render "edit"
    end
  end


 def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "please_log_in"
      redirect_to login_url
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end
   def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
