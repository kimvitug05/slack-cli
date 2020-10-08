require 'httparty'
require 'time'
require 'csv'
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
      raise SlackApiError, "SlackApiError. Reason: #{response["error"]}"
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

    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackApiError, "SlackApiError. Reason: #{response["error"]}"
    end

    return response
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

    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackApiError, "SlackApiError. Reason: #{response["error"]}"
    end

    return response
  end

  def save_message_history(message)
    CSV.open('history.csv', 'a') do |file|
      file << [@name, @slack_id, message, Time.now] if message != ""
    end
  end

  def show_message_history
    history = CSV.read('history.csv', headers: true).map { |row| row.to_h }

    history.select { |recipient| recipient["RECIPIENT"] == @name || recipient["ID"] == @slack_id }
  end
end

class SlackApiError < StandardError; end
