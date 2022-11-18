class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Respondable

  before_action :authenticate_user

  def current_user
    @current_user ||= User.find(@current_user_id)
  end

  private

  def authenticate_user
    return if request.headers['Authorization'].blank?

    authenticate_or_request_with_http_token do |token|
      begin
        jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    end
  end
end
