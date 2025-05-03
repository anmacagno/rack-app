require "json"

class ProductsController < BaseController
  # GET /products
  def index
    response.status = 200
    response.write(find_products.to_json)
  end

  # POST /products
  def create
    response.status = 202 # Accepted
    response.write(create_product.to_json)
  rescue ProductError => e
    response.status = 400
    response.write(error_json("Bad Request: #{e.message}."))
  rescue JSON::ParserError
    response.status = 400
    response.write(error_json("Bad Request: invalid body."))
  end

  private

  def find_products
    Product.all.map { |product| product.to_hash }
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
