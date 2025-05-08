require "jwt"

class JsonWebToken
  SECRET_KEY = ENV["SECRET_KEY"] || "my$ecretK3y".freeze

  # Algorithm used to sign the JWT: HS256 (HMAC using SHA-256 hash algorithm).

  def self.encode(payload, expiration)
    JWT.encode(payload.merge(exp: expiration.to_i), SECRET_KEY)
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY).first
  end
end
