class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enterprise
  before_action :set_product, only: [:show, :update]
  before_action :set_room, only: [:index]

  def index
    if params[:room_id]
      @products = @room.products
    else
      @products = @enterprise.products
    end
    render :index, status: :ok
  end

  def show
    render :show, status: :ok
  end

  def create
    @product = @enterprise.products.new(product_params)

    if @product.save
      render :create, status: :created
    else
      render json: { error: @product.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render :update, status: :ok
    else
      render json: { error: @update.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :purchase_price, :sale_price, :quantity)
  end

  def set_product
    params[:id] = params[:product_id] if params[:product_id]
    @product = @enterprise.products.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def set_enterprise
    @enterprise ||= current_user.enterprise
  end

  def set_room
    @room ||= @enterprise.rooms.find(params[:room_id]) if params[:room_id]
  end
end
