require "rack/cache"
require_relative "app/rack_app"

app = Rack::Builder.app do
  use Rack::Cache,
      metastore: "file:cache/rack/meta",
      entitystore: "file:cache/rack/body",
      verbose: true
  use Rack::Static,
      urls: [
        "/AUTHORS",
        "/openapi.yaml"
      ],
      header_rules: [
        ["AUTHORS", { "cache-control" => "max-age=86400" }], # 24 hours
        ["openapi.yaml", { "cache-control" => "no-store" }]
      ]
  run RackApp.new
end

run app
