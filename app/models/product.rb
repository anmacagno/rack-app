class Product
  attr_accessor :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def self.all
    Storage.instance.products
  end

  def self.find_by(params)
    Storage.instance.products.select { |product| product.name == params["name"] }
  end

  def self.create!(params)
    raise(ProductError, "param name cannot be null") if params["name"].nil?
    raise(ProductError, "param name must be a string") unless params["name"].is_a?(String)
    raise(ProductError, "param name cannot be empty") if params["name"].strip.empty?

    Thread.new {
      sleep(5) # 5 seconds
      product = new(id: all.size + 1, name: params["name"])
      all.push(product)
    }

    { name: params["name"] }
  end

  def to_hash
    { id: id, name: name }
  end

  def to_json(*_args)
    to_hash.to_json
  end
end

class ProductError < StandardError; end
