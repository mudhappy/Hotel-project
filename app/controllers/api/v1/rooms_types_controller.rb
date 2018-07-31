class Api::V1::RoomsTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enterprise
  before_action :set_rooms_type, only: [:show, :update]
  before_action :check_if_the_user_have_permissions, only: [:create, :update]

  def index
    @rooms_types = @enterprise.rooms_types
    render :index, status: :ok
  end

  def create
    @rooms_type = @enterprise.rooms_types.new(rooms_type_params)
    if @rooms_type.save
      render :create, status: :created
    else
      render json: { error: @rooms_type.errors.messages }, status: :created
    end
  end

  def show
    render :show, status: :ok
  end

  def update
    if @rooms_type.update(rooms_type_params)
      render :update, status: :ok
    else
      render json: { error: @rooms_type.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def rooms_type_params
    params.require(:rooms_type).permit(:name, :bed_cuantities, :recommended_price)
  end

  def set_rooms_type
    @rooms_type = @enterprise.rooms_types.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def set_enterprise
    @enterprise ||= current_user.enterprise
  end
end
