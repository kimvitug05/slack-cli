require 'dotenv'
USERS_URL = "https://slack.com/api/users.list"

Dotenv.load

class User
  attr_reader :name, :real_name, :id

  def initialize(name, real_name, id)
    @name = name
    @real_name = real_name
    @id = id
  end

  def self.list_all
    response = HTTParty.get(USERS_URL, query: {
        token: ENV["TOKEN"],
    })

    return response["members"].map do |user|
      {
          user_name: user["name"],
          real_name: user["real_name"],
          id: user["id"]
      }
    end
  end
end