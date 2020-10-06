require 'dotenv'
require_relative 'workspace'
require_relative 'user'
require_relative 'channel'
require 'httparty'

Dotenv.load

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
      puts Channel.list_all
    when "3", "quit"
      continue = false
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME