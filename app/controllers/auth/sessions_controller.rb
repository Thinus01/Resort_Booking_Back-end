module Auth
  class SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token, only: %i[create update]
    def create
      user = User.find_by(email: params[:user][:email])

      if user&.valid_password?(params[:user][:password])
        sign_in(user)
        render json: { message: 'Sign-in successful' }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end
end
