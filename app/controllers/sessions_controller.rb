class SessionsController < ApplicationController
  def create
    @user = User.authenticate params[:username], params[:password]
    if @user
      flash[:notice] = "Logged in successfully"
      session[:user] = @user.id
      redirect_to cocktails_path
    else
      flash[:notice] = "Invalid username or password"
      redirect_to welcome_path
    end
  end

  def destroy
    session[:user] = nil
    # reset_session seems to destroy all cookies, logging me out from facebok, gmail, basicly from everything
    flash[:notice] = "Logged out successfully"
    redirect_to welcome_path
  end
end
