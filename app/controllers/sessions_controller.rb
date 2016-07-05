class SessionsController < ApplicationController

  def new
  end


  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:email])
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
    
    #debugger
  end

  def destroy
  end

end
