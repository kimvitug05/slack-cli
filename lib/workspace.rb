class Workspace
  attr_reader :users, :channels

  def initialize
    @users = []
    @channels = []
  end

  def select_user(name = nil, id = nil)
    if name
      @user.find { |user| user[:name] == name }
    elsif id
      @user.find { |user| user[:id] == id }
    else
      raise ArgumentError, "Please enter a valid name or id."
    end
  end
end
