class UsersController < ApplicationController
  wrap_parameters :user, include: [ :username, :password ]
  skip_before_action :authorized, include: [ :create ]
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.new(user_params)

    if user.save
      @token = encode_token(used_id: user.id)
      render json: { token: @token }, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  protected
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
