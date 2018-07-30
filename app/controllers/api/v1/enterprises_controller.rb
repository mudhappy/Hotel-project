class Api::V1::EnterprisesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_the_user_have_permissions, only: [:create, :update]
  before_action :check_if_the_user_has_already_created_a_enterprise, only: :create
  before_action :set_enterprise, only: [:show, :update]

  def create
    @enterprise = Enterprise.new(enterprise_params)

    if @enterprise.save
      current_user.set_enterprise(@enterprise)
      render :create, status: :created
    else
      render json: { error: @enterprise.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @enterprise.update(enterprise_params)
      render :update, status: :ok
    else
      render json: { error: @enterprise.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    render :show, status: :ok
  end

  private

  def enterprise_params
    params.require(:enterprise).permit(:name, :ruc)
  end

  def set_enterprise
    @enterprise = Enterprise.find(current_user.enterprise_id)
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def check_if_the_user_has_already_created_a_enterprise
    render(
      json: { error: "User can't create another enterprise" },
      status: :unprocessable_entity
    ) if current_user.have_enterprise?
  end
end
