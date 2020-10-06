require 'dotenv'
require_relative 'recipient'
# require 'table_print'
CHANNELS_URL = "https://slack.com/api/conversations.list"

Dotenv.load

class Channel < Recipient
  attr_reader :name, :topic, :member_count, :id

  def initialize(name:, topic:, member_count:, id:)
    # super(id)
    @name = name
    @topic = topic
    @member_count = member_count
    @id = id
  end

  def self.list_all
    response = self.get(CHANNELS_URL, query: {
        token: ENV["TOKEN"],
    })

    return response["channels"].map do |channel|
      self.new({
          name: channel["name"],
          topic: channel["topic"]["value"],
          member_count: channel["num_members"],
          id: channel["id"]
      })
    end
  end

  def details
    return tp self, :name, :member_count, :id, :topic
  end
end