require_relative 'test_helper'

describe Channel do

  before do
    @slack_id = "C0165N9BX3M"
    @name = "general"
    @topic = ""
    @member_count = 105

    @channel = Channel.new(@slack_id, @name, @topic, @member_count)

    VCR.use_cassette("channels") do
      @response = Channel.list_all
    end
  end

  describe "constructor" do
    it "creates a new Channel instance from HTTParty.get command" do
      expect(@channel).must_be_instance_of Channel
    end

    it "matches channel[0]'s data in JSON result" do

      expect(@response.first.slack_id).must_equal @slack_id
      expect(@response.first.name).must_equal @name
      expect(@response.first.topic).must_equal @topic
      expect(@response.first.member_count).must_equal @member_count

    end
  end

  describe "list_all" do
    it "lists all Channel instances" do
      expect(@response.length).must_equal 47
      expect(@response).must_be_instance_of Array

      @response.each do |channel|
        expect(channel).must_be_instance_of Channel
      end
    end
  end

  describe "details" do
    it "prints a table" do
      expect(@channel.details).must_be_instance_of TablePrint::Returnable
    end
  end
end
