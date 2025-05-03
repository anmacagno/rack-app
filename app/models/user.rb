class User
  attr_accessor :id, :username, :password

  def initialize(id:, username:, password:)
    @id = id
    @username = username
    @password = password
  end

  def self.find(params)
    Storage.instance.users.find { |user| user.username == params["username"] && user.password == params["password"] }
  end
end
