class CocktailsController < ApplicationController
  before_action :check_auth
  before_action :set_cocktail, only: [:show, :edit, :update, :destroy]

  # GET /cocktails
  # GET /cocktails.json
  def index
    @cocktails = []
    @auth_user.cocktails.each do |ct|
      @cocktails << ct
    end
  end

  def share
    @to = User.find_by_name(params[:username_to])

    if @to == nil
      render json: {'error': params[:username_to].to_s + " doesn't exist."}, status: 400
      return
    end

    find = @to.cocktails.select {|ct| ct.id == Integer(params[:id])}

    if find.empty?
      @ct = Cocktail.find_by_id(params[:id])
      @to.cocktails << @ct

      @notif = Notification.new(sender: @auth_user.id, item: @ct.id, item_type: 0, seen: false)
      @to.notifications << @notif

      render :json => @ct
    else
      render json: {'error': params[:username_to].to_s + " already have this cocktail."}, status: 400
    end
  end

  # GET /cocktails/1
  # GET /cocktails/1.json
  def show
    if @cocktail.users.select { |user| user == @auth_user }.empty?
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end
  end

  # GET /cocktails/new
  def new
    @cocktail = Cocktail.new(img: "/imgs/glass.jpg")
  end

  # GET /cocktails/1/edit
  def edit
  end

  # POST /cocktails
  # POST /cocktails.json
  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.owner = @auth_user

    respond_to do |format|
      if @cocktail.save
        if (params['cocktail']['ingredients'] != nil)
          for id in params['cocktail']['ingredients']
            @cocktail.ingredients << Ingredient.find(id)
          end
        end
        @auth_user.cocktails << @cocktail
        format.html {redirect_to cocktails_path, notice: 'Cocktail was successfully updated.'}
      else
        format.html {render :new}
        format.json {render json: @cocktail.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /cocktails/1
  # PATCH/PUT /cocktails/1.json
  def update
    respond_to do |format|
      if @cocktail.update(cocktail_params)
        if (params['cocktail']['ingredients'] != nil)
          for id in params['cocktail']['ingredients']
            @cocktail.ingredients << Ingredient.find(id)
          end
        end
        format.html {redirect_to @cocktail, notice: 'Cocktail was successfully updated.'}
        format.json {render :show, status: :ok, location: @cocktail}
      else
        format.html {render :edit}
        format.json {render json: @cocktail.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /cocktails/1
  # DELETE /cocktails/1.json
  def destroy
    notifs = Notification.where(item_type: 0, item: @cocktail.id)
    unless notifs == nil
      notifs.each do |nt|
        nt.destroy
      end
    end

    @cocktail.destroy
    respond_to do |format|
      format.html {redirect_to cocktails_url, notice: 'Cocktail was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def check_auth
    unless session[:user]
      redirect_to welcome_path
      return
    end
    @auth_user = User.find_by_id(session[:user])
    unless @auth_user
      redirect_to logout_path
    end
  end

  def set_cocktail
    @cocktail = Cocktail.find_by_id(params[:id])
    if @cocktail == nil
      render(:file => File.join(Rails.root, 'public/404.html'), :status => 404, :layout => false)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cocktail_params
    params.require(:cocktail).permit(:name, :img, :description, :recipe, {ingredients: [:id]})
  end
end
