require 'test_helper'
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
        params = {token: ENV["TOKEN"]}
        @response = Recipient.get(CHANNELS_URL, query: params )
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
    #TODO
    # it "has a send_message method" do
    #   expect(Recipient).must_respond_to send_message
    # end

    it "can send a valid message" do
      VCR.use_cassette("slack-posts") do
        response = @recipient.send_message("Hey I can post messages!")
        expect(response["ok"]).must_equal true
      end
    end

    it "can send an empty message" do
      VCR.use_cassette("slack-posts") do
        response = @recipient.send_message("   ")
        expect(response["ok"]).must_equal true
      end
    end

    it "can send a super long message" do
      VCR.use_cassette("slack-posts") do
        response = @recipient.send_message("Hi You are beautiful!"*90000)
        expect(response["ok"]).must_equal true
      end
    end

  end

end
