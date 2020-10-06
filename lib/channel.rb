require 'dotenv'
CHANNELS_URL = "https://slack.com/api/conversations.list"

Dotenv.load

class Channel
  attr_reader :name, :topic, :member_count, :id

  def initialize(name:, topic:, member_count:, id:)
    @name = name
    @topic = topic
    @member_count = member_count
    @id = id
  end

  def self.list_all
    response = HTTParty.get(CHANNELS_URL, query: {
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

  def details(channel)
    tp channel
  end
end