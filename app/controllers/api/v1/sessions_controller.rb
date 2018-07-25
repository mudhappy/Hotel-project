class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      render json: user.as_json(only: [:email, :authentication_token]), status: :created
    else
      head(:unauthorized)
    end
  end
end
