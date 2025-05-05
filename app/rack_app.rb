require_relative "controllers/base_controller"
require_relative "controllers/authentication_controller"
require_relative "controllers/products_controller"
require_relative "models/user"
require_relative "models/product"
require_relative "models/storage"
require_relative "utils/json_web_token"

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
      if request.request_method == "OPTIONS"
        response.set_header("Access-Control-Allow-Origin", "*")
        response.set_header("Access-Control-Allow-Headers", "*")
      elsif request.path_info.match?(/\/products\/[0-9]+/)
        ProductsController.new(request, response).show
      else
        BaseController.new(request, response).not_found
      end
    end

    response.finish
  end
end
