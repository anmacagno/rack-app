class Product
  attr_accessor :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def self.all
    Storage.instance.products
  end

  def self.create!(params)
    raise(ProductError, "param name cannot be null") if params["name"].nil?
    raise(ProductError, "param name must be a string") unless params["name"].is_a?(String)
    raise(ProductError, "param name cannot be empty") if params["name"].strip.empty?

    product = new(id: 1, name: params["name"])
    Storage.instance.products.push(product)
    product
  end

  def to_hash
    { id: id, name: name }
  end

  def to_json
    to_hash.to_json
  end
end

class ProductError < StandardError; end
