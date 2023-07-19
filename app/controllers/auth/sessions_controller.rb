module Auth
    class SessionsController < Devise::SessionsController
        def log_in
            user = User.find_by(email: 'user@example.com')
            sign_in(user)
            redirect_to root_path
        end
    end
  end