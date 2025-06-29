class Api::V1::ProductsController < Api::V1::ApplicationController
  before_action :fetch_product, only: %i[show update destroy]

  def index
    @products = Product.all
    render json: @products
  end

  def show
    render json: @product
  end

  def create
    @product = Product.new(product_params)
    return render json: @product if @product.save

    render json: { errors: @product.errors.full_messages }, status: 400
  end

  def update
    return render json: @product if @product.update(product_params)

    render json: { errors: @product.errors.full_messages }, status: 400
  end

  def destroy
    @product.destroy
  
    render json: {}, status: :no_content
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end

  def fetch_product
    @product = Product.find(params[:id])
  end
end