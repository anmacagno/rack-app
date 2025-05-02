require_relative "controllers/base_controller.rb"
require_relative "controllers/authentication_controller.rb"
require_relative "controllers/products_controller.rb"
require_relative "models/product.rb"
require_relative "models/user.rb"
require_relative "utils/json_web_token.rb"

class RackApp
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new

    case [request.request_method, request.path_info]
    when ["GET", "/"]
      BaseController.new(request, response).root
    when ["POST", "/login"]
      AuthenticationController.new(request, response).login
    when ["GET", "/products"]
      ProductsController.new(request, response).index
    when ["POST", "/products"]
      ProductsController.new(request, response).create
    else
      BaseController.new(request, response).not_found
    end

    response.finish
  end
end
