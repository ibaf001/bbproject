class PasswordResetsController < ApplicationController

  before_action :get_user, only: [:edit, :update]
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    #debugger
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] ="Email address not found"
      render 'new'
    end
  end

  def edit
    #@user = comes from get_user method
  end

  def update
  end

  private
  
    def get_user
      @user = User.find_by(email: params[:email])
    end

end
