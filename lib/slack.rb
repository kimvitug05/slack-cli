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
  puts "\nWelcome to the Ada Slack CLI!"


  while continue
    puts "\nWhat do you want to do? => \n1. List Users\n2. List Channels \n3. Select User \n4. Select Channel \n5. Details \n6. Send Message \n7. Quit"
    print "Selection: "
    input = gets.chomp.downcase
    puts

    case input
    when "1", "list users"

      tp workspace.users, :name, :real_name, :slack_id, :status_text, :status_emoji

    when "2", "list channels"

      tp workspace.channels, :name, :member_count, :slack_id, :topic

    when "3", "select user"

      print "Please enter a user name or ID: "
      selection = gets.chomp
      workspace.select_user(selection)

    when "4", "select channel"

      print "Please enter a channel name or ID: "
      selection = gets.chomp
      workspace.select_channel(selection)

    when "5", "details"

      begin
        workspace.show_details
      rescue NoMethodError
        puts "You haven't selected any user or channel yet."
      end

    when "6", "send_message"

      print "Please type in a message to send: "
      message = gets.chomp

      begin
        workspace.send_message(message)
      rescue NoMethodError
        puts "You haven't selected any user or channel yet."
      end
      
    when "7", "quit"

      continue = false

    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME