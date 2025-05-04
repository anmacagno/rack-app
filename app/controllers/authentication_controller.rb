require "json"

class AuthenticationController < BaseController
  # POST /login
  def login
    user = find_user
    if user
      response.status = 200
      response.write(authorize(user).to_json)
    else
      response.status = 401
      response.write(error_json("Unauthorized: invalid username or password."))
    end
  rescue JSON::ParserError
    response.status = 400
    response.write(error_json("Bad Request: invalid body."))
  end

  private

  def find_user
    params = JSON.parse(request.body.read)
    User.find_by(params)
  end

  def set_headers
    response.set_header("Access-Control-Allow-Origin", "*")
    response.set_header("Content-Type", "application/json")
  end
end
