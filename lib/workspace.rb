require_relative 'user'
require_relative 'channel'
require 'httparty'
require 'table_print'
require 'dotenv'
Dotenv.load

class Workspace
  attr_reader :users, :channels
  attr_accessor :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_user(input)
    @selected = @users.find { |user| user.name == input } || @users.find { |user| user.slack_id == input }

    puts "Please enter a valid user name or id." if @selected.nil?
  end

  def select_channel(input)
    @selected = @channels.find { |channel| channel.name == input } || @channels.find { |channel| channel.id == id }

    puts "Please enter a valid channel name or id." if @selected.nil?
  end

  def show_details
    @selected ? @selected.details : ( puts "You haven't selected any user or channel yet." )
  end

  def send_message(message)
    @selected ? @selected.send_message(message) : ( puts "You haven't selected any user or channel yet." )
  end

  def bot_post_message(user_name = "SLACKBOT", emoji = ":sparkles:", message)
    @selected ? @selected.bot_post_message(user_name, emoji, message) : ( puts "You haven't selected any user or channel yet." )
  end

  def save_message_history(message)
    @selected ? @selected.save_message_history(message) : ( puts "You haven't selected any user or channel yet." )
  end

  def show_message_history
    @selected ? @selected.show_message_history : ( puts "You haven't selected any user or channel yet." )
  end
end

