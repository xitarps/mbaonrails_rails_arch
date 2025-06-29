class Api::V1::ProductsController < Api::V1::ApplicationController
  before_action :fetch_product, only: %i[show update destroy]

  def index
    @products = ProductsRepository.search(params[:term]) if params[:term]
    @products ||= ProductsRepository.all
  end

  def show; end

  def create
    @product = ProductsRepository.new(product_params)
    return render :create if @product.save

    render 'api/v1/shared/errors', locals: { object: @product }, status: 400
  end

  def update
    return render :update if @product.update(product_params)

    render 'api/v1/shared/errors', locals: { object: @product }, status: 400
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
    @product = ProductsRepository.find(params[:id])
  end
end