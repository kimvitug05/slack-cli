require_relative 'test_helper'

describe Workspace do
  before do
    VCR.use_cassette("workspace") do
      @workspace = Workspace.new
    end
  end

  describe "constructor" do
    it "creates a new Workspace instance" do
      expect(@workspace).must_be_instance_of Workspace
    end
  end

  describe "select_user" do
    it "can select a User instance" do
      user = @workspace.select_user("li.lea.dai")

      expect(user).must_be_instance_of User
      expect(user.slack_id).must_equal "U016W06JGT1"
      expect(user.name).must_equal "li.lea.dai"
      expect(user.real_name).must_equal "Li Dai"
      expect(user.status_emoji).must_equal ":she-her:"
    end

    it "returns nil if no user/id found" do
      user = @workspace.select_user("fakeUser")

      expect(user).must_be_nil
    end
  end

  describe "select_channel" do
    it "can select a Channel instance" do
      channel = @workspace.select_channel("test-channel2")

      expect(channel).must_be_instance_of Channel
      expect(channel.slack_id).must_equal "C01ABK51G14"
      expect(channel.name).must_equal "test-channel2"
      expect(channel.topic).must_equal ""
      expect(channel.member_count).must_equal 14
    end

    it "returns nil if no user/id found" do
      channel = @workspace.select_channel("fake-channel")

      expect(channel).must_be_nil
    end
  end

  describe "show_details" do
    it "can show details of currently selected user/channel" do
      @workspace.select_user("li.lea.dai")

      expect(@workspace.show_details).must_be_instance_of TablePrint::Returnable
    end

    it "returns nil if no user/channel selected" do
      expect(@workspace.show_details).must_be_nil
    end
  end

  describe "send_message" do
    it "sends a message to user/channel selected" do
      VCR.use_cassette("workspace") do
        @workspace.select_user("li.lea.dai")
        response = @workspace.send_message("Hello there!")
        expect(response["ok"]).must_equal true
      end
    end

    it "returns nil if no user/channel selected" do
      VCR.use_cassette("workspace") do
        response = @workspace.send_message("Hello there!")
        expect(response).must_be_nil
      end
    end
  end

  describe "bot_post_message" do
    it "can send a message as a bot" do
      VCR.use_cassette("workspace") do
        @workspace.select_user("li.lea.dai")
        response = @workspace.bot_post_message("Hello there!")
        expect(response["ok"]).must_equal true
      end
    end

    it "returns nil if no user/channel selected" do
      response = @workspace.bot_post_message("Hello there!")
      expect(response).must_be_nil
    end
  end
end



