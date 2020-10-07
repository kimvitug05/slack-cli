require 'httparty'
BASE_URL = "https://slack.com/api/"

class SlackApiError < StandardError; end

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  #TODO - refactor to not include params (params is always the same). Edit to take endpoint as a parameter
  def self.get(url, params)
    response = HTTParty.get(url, params)

    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackApiError, "SlackApiError!"
    end
    return response
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
