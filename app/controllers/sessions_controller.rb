class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      render_okay json_content: { token: user.generate_jwt, email: user.email }
    else
      render_unprocessable_entity errors: ['email or password is invalid']
    end
  end
end
