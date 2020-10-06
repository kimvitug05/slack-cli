require_relative 'user'
require_relative 'channel'
require 'httparty'
# require 'table_print'
require 'dotenv'
Dotenv.load

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_user(name:nil, id:nil)
    if name
      @selected = @users.find { |user| user.name == name }
    elsif id
      @selected = @users.find { |user| user.name == id }
    else
      raise ArgumentError, "Please enter a valid user name or id."
    end
  end

  def select_channel(channel_name:nil, id:nil)
    if channel_name
      @selected = @channels.find { |channel| channel.name == channel_name }
    elsif id
      @selected = @channels.find { |channel| channel.id == id }
    else
      raise ArgumentError, "Please enter a valid channel name or id."
    end
  end

  def show_details
    return @selected.details
  end
end

