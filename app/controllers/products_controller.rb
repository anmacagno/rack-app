require "json"

class ProductsController < BaseController
  # GET /products
  def index
    authenticate!
    response.status = 200
    response.write(find_products.to_json)
  rescue AuthenticationError => e
    response.status = 401
    response.write(error_json("Unauthorized: #{e.message}."))
  end

  # POST /products
  def create
    authenticate!
    response.status = 202 # Accepted
    response.write(create_product.to_json)
  rescue JSON::ParserError, ProductError => e
    response.status = 400
    response.write(error_json("Bad Request: #{e.message}."))
  rescue AuthenticationError => e
    response.status = 401
    response.write(error_json("Unauthorized: #{e.message}."))
  end

  private

  def find_products
    params = Rack::Utils.parse_nested_query(request.query_string)
    params.has_key?("name") ? Product.find_by(params) : Product.all.map(&:to_hash)
  end

  def create_product
    params = JSON.parse(request.body.read)
    Product.create!(params)
  end

  def set_headers
    response.set_header("Access-Control-Allow-Origin", "*")
    response.set_header("Content-Type", "application/json")
  end
end
