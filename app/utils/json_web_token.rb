require "jwt"

class JsonWebToken
  SECRET_KEY = "my$ecretK3y".freeze

  def self.encode(payload, expiration)
    JWT.encode(payload.merge(exp: expiration.to_i), SECRET_KEY)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY).first
    ActiveSupport::HashWithIndifferentAccess.new(decoded_token)
  end
end
