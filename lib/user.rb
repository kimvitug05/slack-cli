require 'dotenv'
require_relative 'recipient'
require 'table_print'
USERS_URL = "https://slack.com/api/users.list"

Dotenv.load

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end


  def self.list_all
    response = self.get("users.list")

    return response["members"].map do |user|
      self.new(
        user["id"],
        user["name"],
        user["real_name"],
        user["profile"]["status_text"],
        user["profile"]["status_emoji"]
      )
    end
  end

  def details
    return tp self, :name, :real_name, :slack_id, :status_text, :status_emoji
  end
end