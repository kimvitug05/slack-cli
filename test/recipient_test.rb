require_relative 'test_helper'

describe "Recipient" do
  before do
    @slack_id = "C01ABK51G14"
    @name = "test-channel2"
    @recipient  = Recipient.new(@slack_id, @name)
  end
  describe "constructor" do
    it "creates a new Recipient instance" do
      expect(@recipient).must_be_instance_of Recipient
    end
  end

  describe "get" do
    it "get the requested data" do
      VCR.use_cassette("channels") do
        @response = Recipient.get("conversations.list")
        expect(@response["channels"].length).must_equal 47
      end
    end
  end

  describe "details" do
    it "raises an NotImplementedError" do
    expect{@recipient.details}.must_raise NotImplementedError
    end
  end

  describe "list_all" do
    it "raises an NotImplementedError" do
      expect{Recipient.list_all}.must_raise NotImplementedError
    end
  end

  describe "send_message" do
    it "has a send_message method" do
      expect(@recipient).must_respond_to :send_message
    end

    it "can send a valid message" do
      VCR.use_cassette("slack-posts") do
        response = @recipient.send_message("Hey I can post messages!")
        expect( response["ok"] ).must_equal true
      end
    end

    it "can send an empty message" do
      VCR.use_cassette("slack-posts") do
        expect{@recipient.send_message("")}.must_raise SlackApiError
      end
    end

    it "can send a super long message" do
      VCR.use_cassette("slack-posts") do
        response = @recipient.send_message("Hi You are beautiful!"*90000)
        expect( response["ok"] ).must_equal true
      end
    end
  end

  describe "bot_post_message" do
    it "has a bot_post_message method" do
      expect(@recipient).must_respond_to :bot_post_message
    end

    it "can send a message as a bot" do
      VCR.use_cassette("bot_post_message_recipient") do
        response = @recipient.bot_post_message("Ting-Yi",":sparkles:", "Hello there!")
        expect(response["ok"]).must_equal true
        expect(response["message"]["text"]).must_equal "Hello there!"
      end
    end
  end

  describe "save_message_history" do
    it"saves message history" do
      history = CSV.read('history.csv', headers: true)
      length = history.length
      VCR.use_cassette("save_message") do
        @recipient.bot_post_message("Ting-Yi",":sparkles:", "Hello there!")
        @recipient.save_message_history("Hello there!")
        history = CSV.read('history.csv', headers: true)
        expect(history.length).must_equal length + 1
      end
    end
  end

  describe "show_message_history" do
    it "can show the message history of the selected user/channel" do
      history = CSV.read('history.csv', headers: true).map { |row| row.to_h }
      history_length = (history.select { |recipient| recipient["RECIPIENT"] == "li.lea.dai"}).length
      @recipient = Recipient.new("U016W06JGT1", "li.lea.dai")
      length = @recipient.show_message_history.length
      expect(length).must_equal history_length
    end

    it "returns \"no data\" for selected user/channel that does not have history" do
      @recipient = Recipient.new("U01BK9SFNKH", "cool_app")
      length = @recipient.show_message_history.length
      expect(length).must_equal 0
      expect(@recipient.show_message_history).must_be_empty
    end

  end

end

