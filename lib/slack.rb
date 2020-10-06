require 'dotenv'
require_relative 'workspace'
require 'httparty'

CHANNELS_URL = "https://slack.com/api/conversations.list"

Dotenv.load

def list_channels
  response = HTTParty.get(CHANNELS_URL, query: {
      token: "xoxp-1222171918129-1261274944689-1408480907106-983ae5e232993a08337168b03cc11e74",
  })

  return response["channels"].map do |channel|
    {
        name: channel["name"],
        topic: channel["topic"]["value"],
        member_count: channel["num_members"],
        id: channel["id"]
    }
  end
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project

  puts list_channels

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME