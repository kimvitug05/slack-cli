require 'dotenv'
require_relative 'workspace'
require 'httparty'

CHANNELS_URL = "https://slack.com/api/conversations.list"
USERS_URL = "https://slack.com/api/users.list"

Dotenv.load

def list_channels
  response = HTTParty.get(CHANNELS_URL, query: {
      token: "xoxp-1222171918129-1261274944689-1414967123620-e5cc19a67f6f2f4713a3c9a8f31f5f84",
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

def list_users
  response = HTTParty.get(USERS_URL, query: {
      token: "xoxp-1222171918129-1261274944689-1414967123620-e5cc19a67f6f2f4713a3c9a8f31f5f84",
  })

  return response["members"].map do |user|
    {
        user_name: user["name"],
        real_name: user["real_name"],
        id: user["id"]
    }
  end
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "#{list_users.length} users were loaded!"
  puts "#{list_channels.length} channels were loaded!"



  

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME