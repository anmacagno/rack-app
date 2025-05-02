require "json"

class AuthenticationController < BaseController
  # POST /login
  def login
    user = authenticate_user
    if user
      payload = { user_id: user["id"] }
      expiration = Time.now.utc + 86_400 # 24 hours from now
      token = JsonWebToken.encode(payload, expiration)

      response.status = 200
      response.write({ token:, expiration: expiration.strftime('%d-%m-%Y %H:%M') })
    else
      response.status = 401
      response.write(error_json("Unauthorized"))
    end
  rescue JSON::ParserError
    response.status = 400
    response.write(error_json("Bad Request: invalid body."))
  end

  private

  def authenticate_user
    params = JSON.parse(request.body.read)
    User.authenticate(params)
  end

  def set_headers
    response.set_header("Access-Control-Allow-Origin", "*")
    response.set_header("Content-Type", "application/json")
  end
end
