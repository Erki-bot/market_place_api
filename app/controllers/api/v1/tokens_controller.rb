# require "./lib/json_web_token.rb"
class Api::V1::TokensController < ApplicationController
  def create
    jwts = JsonWebToken::JsonWebToken.new
    user = User.find_by_email(user_params[:email])
    if user.authenticate(user_params[:password])
      render json: {
        token: jwts.encode(user_id: user.id),
        email: user.email
      }
    else
      head :unauthorized
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
