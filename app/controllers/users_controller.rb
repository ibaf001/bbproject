class UsersController < ApplicationController
  

  before_action :logged_in_user, only: [:edit, :index, :update, :destroy]
  before_action :correct_logged_in_user, only: [:edit, :update]
  before_action :admin_user , only: :destroy

  def show
    @user = User.find(params[:id])
  
  end


  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_param)
      flash[:success] = "Profile Updated Successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_param)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      #log_in @user
      flash[:info] = "Please check your email to activate your account"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    user = User.find(params[:id])
    username = user.username
    user.destroy
    flash[:success] ="#{username} was deleted successfully"
    redirect_to users_url
  end

  private
  
    def user_param
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end


    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    def correct_logged_in_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end



end




























