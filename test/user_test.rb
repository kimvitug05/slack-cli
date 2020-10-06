require 'test_helper'

describe User do
  before do
    VCR.use_cassette("members") do
      @response = HTTParty.get(USERS_URL, query: {
          token: ENV["TOKEN"]
      })
    end
  end
  describe "constructor" do
    it "creates a new User instance from HTTParty.get command" do
      result = @response["members"].map do |user|
        User.new({
           name: user["name"],
           real_name: user["real_name"],
           id: user["id"]
       })
      end

      expect(result.first).must_be_instance_of User
    end
  end
end