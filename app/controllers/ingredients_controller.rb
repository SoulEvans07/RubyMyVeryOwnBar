class IngredientsController < ApplicationController
  before_action :set_static_list
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = []
    @static_ingredients.each do |ingr|
      @ingredients << ingr
    end
    Ingredient.all.each do |ingr|
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

  # POST /ingredients
  # POST /ingredients.json
  def create
    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
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

  # Use callbacks to share common setup or constraints between actions.
  def set_ingredient
    if Integer(params[:id]) < 0
      @ingredient = @static_ingredients.select {|ingr| ingr.id == Integer(params[:id])}.first
    else
      @ingredient = Ingredient.find(params[:id])
    end

  end

  def set_static_list
    @static_ingredients = []
    @static_ingredients << Ingredient.new(id: -1, name: "Static Ingredient 1", img: "/imgs/ingredient.jpeg", have: true)
    @static_ingredients << Ingredient.new(id: -2, name: "Static Ingredient 2", img: "/imgs/ingredient.jpeg", have: true)
    @static_ingredients << Ingredient.new(id: -3, name: "Static Ingredient 3", img: "/imgs/ingredient.jpeg")
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ingredient_params
    params.require(:ingredient).permit(:name, :img, :description, :have)
  end
end
