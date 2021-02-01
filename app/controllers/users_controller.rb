class UsersController < ApplicationController
  before_action :load_user
  before_action :correct_user, only: [:edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]

  def current_user?(user)
    user == current_user
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end
  def new
    @user = User.new
  end

  def destroy
    @user.destroy
    flash[:success] = t"deleted"
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] =  t "update"
      redirect_to @user
    else
      render :edit
    end
  end


  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] =  t"please_log_in"
      redirect_to login_url
    end
  end

  def following
    @title = t("following")
    @users = @user.following
    .paginate(page: params[:page])
    render "show_follow"
  end
  def followers
    @title = t("followers")
    @users = @user.followers
    .paginate(page: params[:page])
    render "show_follow"
  end

  def load_user
    @user = User.find_by(id: params[:id])
    return if @users

    # flash.now[:danger] = t"user_not_found"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
    :password_confirmation
  end
  def correct_user
    redirect_to(root_url) unless @user == current_user
  end
end
