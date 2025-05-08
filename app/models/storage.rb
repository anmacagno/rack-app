require "singleton"

class Storage
  include Singleton

  attr_accessor :users, :products

  def initialize
    @users = [
      User.new(id: 1, username: "amacagno", password: "1111")
    ]
    @products = []
    @last_product_id = 0
  end

  def product_id
    @last_product_id += 1
  end
end
