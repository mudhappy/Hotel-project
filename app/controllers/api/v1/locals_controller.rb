class Api::V1::LocalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enterprise
  before_action :set_local, only: [:show, :update]
  before_action :check_if_the_user_have_permissions, only: [:create, :update]

  def index
    @locals = @enterprise.locals
    render :index, status: :ok
  end

  def create
    @local = @enterprise.locals.new(local_params)
    if @local.save
      render :create, status: :created
    else
      render json: { error: @local.errors.messages }, status: :created
    end
  end

  def show
    render :show, status: :ok
  end

  def update
    if @local.update(local_params)
      render :update, status: :ok
    else
      render json: { error: @local.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def local_params
    params.require(:local).permit(:address, :stars)
  end

  def set_enterprise
    @enterprise ||= current_user.enterprise
  end

  def set_local
    @local ||= @enterprise.locals.find(params[:id])
  end
  
end
