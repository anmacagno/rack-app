require "singleton"

class Storage
  include Singleton

  attr_accessor :users, :products

  def initialize
    @users = [
      User.new(id: 1, username: 'amacagno', password: '1111'),
      User.new(id: 2, username: 'jcuello', password: '2222'),
      User.new(id: 3, username: 'lbierwerth', password: '3333')
    ]
    @products = []
    @last_product_id = 0
  end

  def product_id
    @last_product_id += 1
  end
end
