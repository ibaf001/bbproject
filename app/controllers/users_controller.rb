class UsersController < ApplicationController
  

  before_action :logged_in_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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
      log_in @user
      flash[:success] = "Welcome to LoBa"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  private
  
    def user_param
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end


    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

end
