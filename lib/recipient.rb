require 'httparty'
BASE_URL = "https://slack.com/api/"

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(endpoint)
    response = HTTParty.get("#{BASE_URL + endpoint}",
                            query: {token: ENV["TOKEN"] })

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

  def bot_post_message(user_name, emoji, message)
    url = "#{BASE_URL}chat.postMessage"

    response = HTTParty.post(url,
       headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
       body: {
           token: ENV["BOT_TOKEN"],
           channel: @slack_id,
           text: message,
           icon_emoji: emoji,
           username: user_name
       }
    )
  end
end

class SlackApiError < StandardError; end
