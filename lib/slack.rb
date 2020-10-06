require 'dotenv'
require_relative 'workspace'
require_relative 'user'
require_relative 'channel'
require 'httparty'
require 'table_print'


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
      tp workspace.users
      # tp workspace.users, :name, :real_name, :id
    when "2", "list channels"
      workspace.show_details

      # tp workspace.channels, :name, :member_count, :id, :topic
    when "3", "quit"
      continue = false
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME