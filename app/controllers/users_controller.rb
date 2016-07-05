class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
  
  end

  def new
    @user = User.new
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

end
