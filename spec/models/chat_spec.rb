require 'rails_helper'

RSpec.describe Chat, type: :model do
  before do
    @chat = Chat.create(name: "Test Chat")
  end

  describe "Associations" do
    it "has many chat_users" do
      expect(@chat.chat_users).to be_empty
    end

    it "has many users through chat_users" do
      expect(@chat.users).to be_empty
    end

    it "has many messages" do
      expect(@chat.messages).to be_empty
    end
  end

  describe "validations" do
    it "is valid  name" do
      expect(@chat).to be_valid
    end 
  end
end
