require "test/unit"
require "rack/test"
require_relative "../app/rack_app.rb"

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
    assert_equal "404 Not Found\n", last_response.body
  end
end
