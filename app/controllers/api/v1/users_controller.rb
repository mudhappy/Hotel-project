class Api::V1::UsersController < ApplicationController
  before_action :set_user

  def show
    render :show, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end
end
