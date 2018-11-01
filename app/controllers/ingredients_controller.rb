class IngredientsController < ApplicationController
  before_action :check_auth
  before_action :set_ingredient, only: [:show, :edit, :have, :update, :destroy]

  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = []
    @user.ingredients.each do |ingr|
      @ingredients << ingr
    end
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new(img: "/imgs/ingredient.jpeg")
  end

  # GET /ingredients/1/edit
  def edit
  end

  def have
    @ingredient.have = params[:checked]
    unless Integer(params[:id]) < 0
      @ingredient.save
    end
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        @user.ingredients << @ingredient

        format.html {redirect_to @ingredient, notice: 'Ingredient was successfully created.'}
        format.json {render :show, status: :created, location: @ingredient}
      else
        format.html {render :new}
        format.json {render json: @ingredient.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html {redirect_to @ingredient, notice: 'Ingredient was successfully updated.'}
        format.json {render :show, status: :ok, location: @ingredient}
      else
        format.html {render :edit}
        format.json {render json: @ingredient.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html {redirect_to ingredients_url, notice: 'Ingredient was successfully destroyed.'}
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

  # Use callbacks to share common setup or constraints between actions.
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ingredient_params
    params.require(:ingredient).permit(:name, :img, :description, :have)
  end
end
