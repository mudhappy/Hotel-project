class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.valid_password?(params[:password])
      render 'api/v1/users/create', status: :created
    else
      head(:unauthorized)
    end
  end
end
