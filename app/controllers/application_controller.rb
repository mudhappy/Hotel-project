class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback: :none

  def check_if_the_user_have_permissions
    render(
      json: { error: 'User does not have permissions' },
      status: :unauthorized
    ) if current_user.employee?
  end
end
