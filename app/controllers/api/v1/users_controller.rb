class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    render :show, status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :create, status: :created
    else
      render json: { error: @user.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
