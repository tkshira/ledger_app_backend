class ApplicationController < ActionController::API
  before_action :authorized
  before_action :cors_set_access_control_headers
  before_action :current_user

  def cors_preflight_check
    if request.method == "OPTIONS"
      cors_set_access_control_headers
      render text: "", content_type: "plain/text"
    end
  end

  protected
  def cors_set_access_control_headers
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Credentials"] = "true"
    response.headers["Access-Control-Allow-Methods"] = "POST, GET, PUT, PATCH, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email"
    response.headers["Access-Control-Max-Age"] = "86400"
  end

  JWT_SECRET = "my-secret-key12345"
  def encode_token(payload)
    JWT.encode(payload, JWT_SECRET)
  end

  def decode_token
    header = request.headers["Authorization"]
    if header
      # token = header.split(".")[1]
      begin
        JWT.decode(header, JWT_SECRET)
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decode_token
      id = decode_token[0]["user_id"]
      @current_user = User.find(id)
    end
  end

  def authorized
    unless !!current_user
      render json: { message: "Please log in" }, status: :unauthorized
    end
  end
end
