require 'dotenv'
require_relative 'workspace'
require 'httparty'

CHANNELS_URL = "https://slack.com/api/conversations.list"
USERS_URL = "https://slack.com/api/users.list"

Dotenv.load

def list_channels
  response = HTTParty.get(CHANNELS_URL, query: {
      token: "xoxp-1222171918129-1234006628919-1405389133525-70a09ce2b511255859fb7b95c8733cfc",
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
      token: "xoxp-1222171918129-1234006628919-1405389133525-70a09ce2b511255859fb7b95c8733cfc",
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
  workspace = Workspace.new
  continue = true
  puts "#{list_users.length} users and #{list_channels.length} channels were loaded!"
  while continue
    puts "Welcome to the Ada Slack CLI!"
    puts "What do you want to do? => \n1. list users\n2. list channels \n3. quit"
    input = gets.chomp

    case input
    when "1", "list users"
      puts list_users
    when "2", "list channels"
      puts list_channels
    when "3", "quit"
      continue = false
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME