require "singleton"

class User
  include Singleton

  attr_accessor :all

  def initialize
    @all = [
      { username: 'amacagno', password: '1111' },
      { username: 'jcuello', password: '2222' },
      { username: 'lbierwerth', password: '3333' }
    ]
  end

  def self.all
    instance.all.map.with_index { |each, index| { id: index + 1 }.merge(each) }
  end

  def self.authenticate(params)
    user = { username: params["username"], password: params["password"] }
    index = instance.all.index { |each| each == user }
    index ? all[index] : nil # user or nil
  end
end
