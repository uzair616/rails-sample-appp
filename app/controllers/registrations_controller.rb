class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(sign_up_params)

    if user.save
      render json: { token: user.generate_jwt, email: user.email }
    else
      render json: { errors: user.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end
end
