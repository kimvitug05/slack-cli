require 'dotenv'
require_relative 'WORKSPACE'
require_relative 'user'
require_relative 'channel'
require 'httparty'
require 'table_print'
require 'json'
WORKSPACE = Workspace.new


Dotenv.load

def main
  continue = true
  puts "#{WORKSPACE.users.length} users and #{WORKSPACE.channels.length} channels were loaded!"
  puts "\nWelcome to the Ada Slack CLI!"

  while continue
    menu_options
    print "Selection: "
    input = gets.chomp.downcase
    puts

    case input
    when "1", "list users"
      list_users
    when "2", "list channels"
      list_channels
    when "3", "select user"
      select_user
    when "4", "select channel"
      select_channel
    when "5", "details"
      details
    when "6", "send message"
      send_message
    when "7", "bot send message"
      bot_send_message
    when "8", "update settings"
      update_settings
    when "9", "show message history"
      show_message_history
    when "10", "quit"
      continue = false
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

def list_users
  tp WORKSPACE.users, :name, :real_name, :slack_id, :status_text, :status_emoji
end

def list_channels
  tp WORKSPACE.channels, :name, :member_count, :slack_id, :topic
end

def select_user
  print "Please enter a user name or ID: "
  selection = gets.chomp
  WORKSPACE.select_user(selection)
end

def select_channel
  print "Please enter a channel name or ID: "
  selection = gets.chomp
  WORKSPACE.select_channel(selection)
end

def details
  WORKSPACE.show_details
end

def send_message
  print "Please type in a message to send: "
  message = gets.chomp
  WORKSPACE.send_message(message)
  WORKSPACE.save_message_history(message)
end

def bot_send_message
  print "Please type in a message to send: "
  message = gets.chomp

  file = File.read("bot-settings.json")
  data_hash = JSON.parse(file)

  WORKSPACE.bot_post_message(data_hash["username"], data_hash["icon_emoji"], message)
  WORKSPACE.save_message_history(message)
end

def update_settings
  print "Please type in a user name: "
  user_name = gets.chomp
  print "Please type in an emoji to use as your icon. For example ':sparkles:' "
  emoji = gets.chomp

  temp_hash = {
      "icon_emoji" => emoji,
      "username" => user_name
  }

  File.write("bot-settings.json", JSON.dump(temp_hash))
end

def menu_options
  puts "\nWhat do you want to do?"
  options = [
      "List Users",
      "List Channels",
      "Select User",
      "Select Channel",
      "Details",
      "Send Message",
      "Send Message as a Bot",
      "Update Settings",
      "Show Message History",
      "Quit"
  ]

  options.each_with_index do |option, i|
    puts "#{i + 1}. #{option}"
  end

  puts
end

def show_message_history
  tp WORKSPACE.show_message_history
end

main if __FILE__ == $PROGRAM_NAME