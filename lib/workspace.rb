class Workspace
  attr_reader :users, :channels

  def initialize
    @users = []
    @channels = []
  end

  def select_user(name = nil, id = nil)
    if name
      @users.find { |user| user[:name] == name }
    elsif id
      @users.find { |user| user[:id] == id }
    else
      raise ArgumentError, "Please enter a valid user name or id."
    end
  end

  def select_channel(channel_name = nil, id = nil)
    if channel_name
      @channels.find { |channel| channel[:name] == channel_name }
    elsif id
      @channels.find { |channel| channel[:id] == id }
    else
      raise ArgumentError, "Please enter a valid channel name or id."
    end
  end
end
