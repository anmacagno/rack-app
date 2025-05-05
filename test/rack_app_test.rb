require "test/unit"
require "rack/test"
require_relative "../app/rack_app"

class RackAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    RackApp.new
  end

  def test_root
    get "/"

    assert last_response.ok?
    assert_equal "Welcome to RackApp!\n", last_response.body
  end

  def test_not_found
    get "/users"

    assert last_response.not_found?
    assert_equal "Not Found\n", last_response.body
  end

  def test_post_login
    post("/login", JSON.generate("username" => "amacagno", "password" => "1111"))

    assert last_response.ok?
    assert JSON.parse(last_response.body).has_key?("token")
  end

  def test_get_products
    header "Authorization", token
    get "/products"

    assert last_response.ok?
    assert_equal [], JSON.parse(last_response.body)
  end

  def test_post_products
    header "Authorization", token
    post("/products", JSON.generate("name" => "MacBook Pro"))

    assert last_response.accepted?
  end

  def test_get_product
    header "Authorization", token
    get "/products/1"

    assert last_response.not_found?
  end

  private

  def token
    post("/login", JSON.generate("username" => "amacagno", "password" => "1111"))
    JSON.parse(last_response.body)["token"]
  end
end
