class CocktailsController < ApplicationController
  before_action :check_auth
  before_action :set_static_list
  before_action :set_cocktail, only: [:show, :edit, :update, :destroy]

  # GET /cocktails
  # GET /cocktails.json
  def index
    @cocktails = []
    @static_cocktails.each do |ct|
      @cocktails << ct
    end
    @user.cocktails.each do |ct|
      @cocktails << ct
    end
  end

  def share
    @with = User.find_by_name(params[:user])
    logger.info(@with)
    @ct = Cocktail.find_by_id(params[:id])
    logger.info(@ct)
    @with.cocktails << @ct
  end

  # GET /cocktails/1
  # GET /cocktails/1.json
  def show
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

    respond_to do |format|
      if @cocktail.save
        if (params['cocktail']['ingredients'] != nil)
          for id in params['cocktail']['ingredients']
            @cocktail.ingredients << Ingredient.find(id)
          end
        end
        @user.cocktails << @cocktail

        format.html {redirect_to @cocktail, notice: 'Cocktail was successfully created for '+@user.name+'.'}
        format.json {render :show, status: :created, location: @cocktail}
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
    end
    @user = User.find_by_id(session[:user])
    unless @user
      redirect_to logout_path
    end
  end

  def set_cocktail
    if Integer(params[:id]) < 0
      @cocktail = @static_cocktails.select {|ct| ct.id == Integer(params[:id])}.first
    else
      @cocktail = Cocktail.find(params[:id])
    end
  end

  def set_static_list
    @static_user = User.new(id: -1)
    @static_ingr = Ingredient.new(id: -1, name: "Static Cocktail Ingredient 1",
                                  img: "/imgs/ingredient.jpeg", have: true,
                                  description: "tremplate description")
    @static_cocktails = []
    @static_cocktails <<
        Cocktail.new(id: -1, name: "Static Editable Cocktail 1",
                     description: "Only editable by the user with id 1",
                     recipe: "template recipe",
                     ingredients: [@static_ingr],
                     img: "/imgs/glass.jpg", users: [User.first])
    @static_cocktails <<
        Cocktail.new(id: -2, name: "Static Shared Cocktail",
                     description: "Owned by a static user, your user can't edit it.",
                     recipe: "template recipe",
                     ingredients: [@static_ingr],
                     img: "/imgs/glass.jpg", users: [@static_user])
    @static_cocktails <<
        Cocktail.new(id: -3, name: "Static Editable Cocktail 2",
                     description: "Only editable by the user with id 1",
                     recipe: "template recipe",
                     img: "/imgs/glass.jpg", users: [User.first])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cocktail_params
    params.require(:cocktail).permit(:name, :img, :description, :recipe, {ingredients: [:id]})
  end
end
