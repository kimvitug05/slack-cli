require 'httparty'
BASE_URL = "https://slack.com/api/"

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

  def send_message(message)
    url = "#{BASE_URL}chat.postMessage"

    response = HTTParty.post(url,
       headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
       body: {
           token: ENV["TOKEN"],
           channel: @slack_id,
           text: message
       }
    )
  end
end
