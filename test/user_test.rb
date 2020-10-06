require 'test_helper'

describe User do
  before do
    @id = "USLACKBOT"
    @name = "slackbot"
    @real_name = "Slackbot"
    @user = User.new(name: @name, real_name: @real_name, id: @id)

    VCR.use_cassette("members") do
      @response = User.list_all
    end
  end
  describe "constructor" do

    it "creates a new User instance from HTTParty.get command" do
      expect(@user).must_be_instance_of User
    end

    it "matches member[0]'s data in JSON result" do

      expect(@response.first.id).must_equal @id
      expect(@response.first.name).must_equal @name
      expect(@response.first.real_name).must_equal @real_name
    end
  end

  describe "list_all" do
    it "list" do
      expect(@response.length).must_equal 156
    end
  end
end