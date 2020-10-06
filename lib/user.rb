require 'dotenv'
require_relative 'recipient'
require 'table_print'
USERS_URL = "https://slack.com/api/users.list"

Dotenv.load

class User < Recipient
  attr_reader :name, :real_name, :id

  def initialize(name:, real_name:, id:)
    # super(id, name)
    @id = id
    @real_name = real_name
    @name = name
  end


  def self.list_all
    response = self.get(USERS_URL, query: {
        token: ENV["TOKEN"],
    })
    return response["members"].map do |user|
      self.new({
          name: user["name"],
          real_name: user["real_name"],
          id: user["id"]
      })
    end
  end

  def details
    return tp self, :name, :real_name, :id

  end

end