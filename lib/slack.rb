require 'dotenv'
require_relative 'workspace'
require_relative 'user'
require 'httparty'

CHANNELS_URL = "https://slack.com/api/conversations.list"
USERS_URL = "https://slack.com/api/users.list"
Dotenv.load

def list_channels
  response = HTTParty.get(CHANNELS_URL, query: {
      token: ENV["TOKEN"],
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
  workspace = Workspace.new
  continue = true
  # puts "#{list_users.length} users and #{list_channels.length} channels were loaded!"
  while continue
    puts "Welcome to the Ada Slack CLI!"
    puts "What do you want to do? => \n1. list users\n2. list channels \n3. quit"
    input = gets.chomp

    case input
    when "1", "list users"
      puts User.list_all
    when "2", "list channels"
      puts list_channels
    when "3", "quit"
      continue = false
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME