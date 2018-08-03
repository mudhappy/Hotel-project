class Api::V1::RoomsController < ApplicationController
  before_action :set_enterprise
  before_action :set_room, only: [:update, :show]

  def create
    @room = @enterprise.rooms.new(room_params)
    if @room.save
      render :create, status: :created
    else
      render json: { error: @room.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render :update, status: :ok
    else
      render json: { error: @room.errors.messages }, status: :unprocessable_entity
    end
  end

  def index
    @rooms = @enterprise.get_rooms(params[:rooms_state_id], params[:rooms_type_id])
    render :index, status: :ok
  end

  def show
    render :show, status: :ok
  end

  private

  def room_params
    params.require(:room).permit(
      :price,
      :dni,
      :roomer_quantities,
      :left_at,
      :rooms_type_id,
      :rooms_state_id
    )
  end

  def set_enterprise
    @enterprise ||= current_user.enterprise
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def set_room
    @room ||= @enterprise.rooms.find(params[:id])
  end

end
