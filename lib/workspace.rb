require_relative 'user'
require_relative 'channel'
require 'httparty'
require 'table_print'
require 'dotenv'
Dotenv.load

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_user(input)
    @selected = nil

    #TODO -- REFACTOR
    if @selected.nil?
      @selected = @users.find { |user| user.name == input }
    elsif @selected.nil?
      @selected = @users.find { |user| user.slack_id == input }
    end

    if @selected.nil?
      puts "Please enter a valid user name or id."
    end
  end

  def select_channel(input)
    @selected = nil

    #TODO -- REFACTOR
    if @selected.nil?
      @selected = @channels.find { |channel| channel.name == input }
    elsif @selected.nil?
      @selected = @channels.find { |channel| channel.id == id }
    elsif @selected.nil?
      puts "Please enter a valid channel name or id."
    end
  end

  def show_details
    @selected.details
  end
end

