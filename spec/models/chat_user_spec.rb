require 'rails_helper'

RSpec.describe ChatUser, type: :model do
  before do
    @user = User.create(email: "saloni123@example.com", password: "password123")
    @chat = Chat.create(name: "testchat")
    @chat_user = ChatUser.create(user: @user, chat: @chat)
  end

  describe "Associations" do
    it "belongs to a user" do
      expect(@chat_user.user).to eq(@user)
    end

    it "belongs to a chat" do
      expect(@chat_user.chat).to eq(@chat)
    end
  end

  describe "Validations" do
    it "is valid with a user and a chat" do
      expect(@chat_user).to be_valid
    end

    it "is not valid without a user" do
      @chat_user.user = nil
      expect(@chat_user).not_to be_valid
    end

    it "is not valid without a chat" do
      @chat_user.chat = nil
      expect(@chat_user).not_to be_valid
    end
  end
end
