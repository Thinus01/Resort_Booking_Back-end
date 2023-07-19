  module Auth
    class RegistrationsController < Devise::RegistrationsController
      def create
        user = User.new(user_params)
      
        if user.save
          render json: { message: 'User registration successful' }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    
      private
    
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
end