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
    { message: message }.to_json
  end
end
