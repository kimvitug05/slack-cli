require 'httparty'
class Recipient
  attr_reader :id, :name

  def initialize
    @id = id
    @name = name
  end

  def self.get(url, params)
    return HTTParty.get(url, params)
  end

  def details
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end

end
