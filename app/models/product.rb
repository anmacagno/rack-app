require "singleton"

class Product
  include Singleton

  attr_accessor :all

  def initialize
    @all = []
  end

  def self.all
    instance.all.map.with_index { |each, index| { id: index + 1 }.merge(each) }
  end

  def self.create!(params)
    raise(ProductError, "param name cannot be null") if params["name"].nil?
    raise(ProductError, "param name must be a string") unless params["name"].is_a?(String)
    raise(ProductError, "param name cannot be empty") if params["name"].strip.empty?

    instance.all.push({ name: params["name"] })
    all.last # product
  end
end

class ProductError < StandardError; end
