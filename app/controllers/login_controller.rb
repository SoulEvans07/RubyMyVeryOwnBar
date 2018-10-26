class LoginController < ApplicationController
  def show
    if session[:user]
      redirect_to cocktails_path
    end
  end
end
