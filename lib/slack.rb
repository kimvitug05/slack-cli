require 'dotenv'
require_relative 'workspace'
require 'httparty'

CHANNELS_URL = "https://slack.com/api/conversations.list"

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project

  response = HTTParty.get(CHANNELS_URL, query: {
      token: ENV["slack_token"],
  })

  pp response

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME