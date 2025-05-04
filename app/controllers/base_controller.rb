class BaseController
  attr_accessor :request, :response

  def initialize(request, response)
    @request = request
    @response = response
    set_headers
  end

  def root
    response.status = 200
    response.write("Welcome to RackApp!\n")
  end

  def not_found
    response.status = 404
    response.write("Not Found\n")
  end

  private

  def set_headers
    response.set_header("Content-Type", "text/plain; charset=utf-8")
  end

  def error_json(message)
    { message: }.to_json
  end

  def authorize(user)
    payload = { user_id: user.id }
    expiration = Time.now.utc + 86_400 # 24 hours from now
    token = JsonWebToken.encode(payload, expiration)
    { token:, expiration: expiration.strftime('%d-%m-%Y %H:%M') }
  end

  def authenticate_request
    token = request.get_header("HTTP_AUTHORIZATION")
    decoded_token = JsonWebToken.decode(token)
    User.find(decoded_token["user_id"])
    true
  rescue JWT::DecodeError => e
    response.status = 401
    response.write(error_json("Unauthorized: #{e.message}."))
    false
  end
end
