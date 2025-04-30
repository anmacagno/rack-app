class RackApp
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new

    case request.path_info
    when "/"
      response.status = 200
      response.write("Welcome to RackApp!\n")
    else
      response.status = 404
      response.write("404 Not Found\n")
    end

    response.finish
  end
end
