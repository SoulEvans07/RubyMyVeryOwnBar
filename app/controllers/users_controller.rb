class UsersController < ApplicationController
  before_action :check_auth
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    unless @auth_user == @user
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end
    @user.notifications.each do |notif|
      unless notif.seen
        notif.seen = true
        notif.save
      end
    end
  end

  def clear_notifs
    @auth_user.notifications.clear
    redirect_to profile_path
  end

  # GET /users/new
  def new
  end

  # GET /users/1/edit
  def edit
  end

  # GET /users/forgotten
  def forgotten
  end

  # POST /users/recover
  def recover
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.img = "/imgs/user.png"

    respond_to do |format|
      if @user.save
        format.html {redirect_to welcome_path, notice: 'User was successfully created.'}
        format.json {render :show, status: :created, location: @user}
      else
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to profile_path, notice: 'User was successfully updated.'}
        format.json {render :show, status: :ok, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to users_path, notice: 'User was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def check_auth
    unless session[:user]
      redirect_to welcome_path
    end
    @auth_user = User.find_by_id(session[:user])
    # If can't find the logged in user, destroy session
    unless @auth_user
      redirect_to logout_path
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_id(params[:id])
    if @user == nil
      render(:file => File.join(Rails.root, 'public/404.html'), :status => 404, :layout => false)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :img, :password, :password_confirmation)
  end
end
