require 'test_helper'

describe User do

  describe "constructor" do
    before do
      # VCR.use_cassette("members") do
      #   @response =
      #       HTTParty.get(USERS_URL, query: {
      #       token: ENV["TOKEN"]
      #   })
      #
      #   @result = @response["members"].map do |user|
      #     User.new({
      #                  name: user["name"],
      #                  real_name: user["real_name"],
      #                  id: user["id"]
      #              })
        end
      end
    end

    it "creates a new User instance from HTTParty.get command" do
      expect(@result.first).must_be_instance_of User
    end

    it "matches member[0]'s data in JSON result" do
      id = "USLACKBOT"
      name = "slackbot"
      real_name = "Slackbot"

      expect(@result.first.id).must_equal id
      expect(@result.first.name).must_equal name
      expect(@result.first.real_name).must_equal real_name
    end
  end

  describe "list_all" do
    it "list" do
      id = "USLACKBOT"
      name = "slackbot"
      real_name = "Slackbot"

      User.new(name: name, real_name: real_name, id: id)

      expect(User.list_all.length).must_equal 1
    end
  end
end