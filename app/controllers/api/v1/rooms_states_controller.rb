class Api::V1::RoomsStatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enterprise
  before_action :set_rooms_state, only: [:show, :update]
  before_action :check_if_the_user_have_permissions, only: [:create, :update]

  def index
    @rooms_states = @enterprise.rooms_states
    render :index, status: :ok
  end

  def create
    @rooms_state = @enterprise.rooms_states.new(rooms_state_params)
    if @rooms_state.save
      render :create, status: :created
    else
      render json: { error: @rooms_state.errors.messages }, status: :created
    end
  end

  def show
    render :show, status: :ok
  end

  def update
    if @rooms_state.update(rooms_state_params)
      render :update, status: :ok
    else
      render json: { error: @rooms_state.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def rooms_state_params
    params.require(:rooms_state).permit(:name)
  end

  def set_rooms_state
    @rooms_state = @enterprise.rooms_states.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def set_enterprise
    @enterprise ||= current_user.enterprise
  end
end
