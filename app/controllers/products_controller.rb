class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]
  before_action :set_user_product, only: %i[edit update destroy]
  before_action :authenticate_user!, only: %i[new create destroy]

  # GET /products
  # GET /products.json
  def index
    @categories = Category.all
    @products = Product.includes(:category).all.page(params[:page])
    @products = @products.category(params[:category]) if params[:category].present?
    return unless params[:sort_column].present? && Product.column_names.include?(params[:sort_column]) && (params[:sort_type] == 'DESC' || params[:sort_type] == 'ASC')
    @products = @products.order_by(params[:sort_column], params[:sort_type])
  end

  def search
    @products = Product.search_like(params[:q]).page(params[:page])
  end

  # GET /products/1
  # GET /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # # GET /products/1/edit
  def edit; end

  # # POST /products
  # # POST /products.json
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /products/1
  # # PATCH/PUT /products/1.json
  def update
    if !@product.nil?
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to @product, notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :index, notice: :unprocessable_entity }
        format.json { render json: 'Error', status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /products/1
  # # DELETE /products/1.json
  def destroy
    if !@product.nil?
      @product.destroy
      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render :index, notice: :unprocessable_entity }
        format.json { render json: 'Error', status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find_by(id: params[:id]) unless params[:id].nil? && params[:id].is_a?(Numeric)
  end

  def set_user_product
    @product = current_user.products.find_by(id: params[:id]) unless params[:id].nil? && params[:id].is_a?(Numeric)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :image)
  end
end
