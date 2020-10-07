require 'httparty'

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
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


  def send_message(message, channel)
    url = "#{BASE_URL}chat.postMessage"

    response = HTTParty.post(url,
       headers: {},
       body: {
           token: ENV["TOKEN"],
           channel: channel,
           text: message
       }
    )
  end
end
