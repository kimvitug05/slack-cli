require 'dotenv'
require_relative 'recipient'
require 'table_print'
CHANNELS_URL = "https://slack.com/api/conversations.list"

Dotenv.load

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def self.list_all
    response = self.get(CHANNELS_URL, query: {
        token: ENV["TOKEN"],
    })

    return response["channels"].map do |channel|
      self.new(
        channel["id"],
        channel["name"],
        channel["topic"]["value"],
        channel["num_members"],
      )
    end
  end

  def details
    return tp self, :name, :member_count, :slack_id, :topic
  end
end