require 'test_helper'
require 'awesome_print'

describe User do
  before do
    @slack_id = "USLACKBOT"
    @name = "slackbot"
    @real_name = "Slackbot"
    @status_text = ""
    @status_emoji = ""
    @user = User.new(@slack_id, @name, @real_name, @status_text, @status_emoji)

    VCR.use_cassette("members") do
      @response = User.list_all
    end
  end
  describe "constructor" do

    it "creates a new User instance from HTTParty.get command" do
      expect(@user).must_be_instance_of User
    end

    it "matches member[0]'s data in JSON result" do

      expect(@response.first.slack_id).must_equal @slack_id
      expect(@response.first.name).must_equal @name
      expect(@response.first.real_name).must_equal @real_name
      expect(@response.first.status_text).must_be_nil
      expect(@response.first.status_emoji).must_be_nil

    end
  end

  describe "list_all" do
    it "lists all User instances" do
      expect(@response.length).must_equal 150
      expect(@response).must_be_instance_of Array

      @response.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

  describe "details" do
    it "prints a table" do
      expect(@user.details).must_be_instance_of TablePrint::Returnable
    end
  end
end