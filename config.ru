require "rack/cache"
require_relative "app/rack_app.rb"

app = Rack::Builder.app do
  use Rack::Cache,
    metastore: "file:cache/rack/meta",
    entitystore: "file:cache/rack/body",
    verbose: true
  run RackApp.new
end

run app
