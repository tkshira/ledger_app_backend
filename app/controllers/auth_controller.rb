class AuthController < ApplicationController
  skip_before_action :authorized, include: [ :login ]
  def login
    @user = User.find_by(username: login_params[:username])
    if @user.authenticate(login_params[:password])
      @token = encode_token(user_id: @user.id)
      render json: { token: @token }
    else
      render json: { message: "Username of password is invalid" }, status: :unauthorized
    end
  end

  def validate_token
    @token = params[:token]
    decode_token()
  end

  private
    def login_params
      params.permit(:username, :password)
    end
end
