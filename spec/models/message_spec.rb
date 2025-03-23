require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @user = User.create(email: "saloni@gmail.com", password: "password123")
    @chat = Chat.create(name: "Test Chat")
    @message = Message.create(content: "Hello, welcome my new chat ", user: @user, chat: @chat)
  end

  describe "associations" do
    it "belongs to a user" do
      expect(@message.user).to eq(@user)
    end

    it "belongs to a chat" do
      expect(@message.chat).to eq(@chat)
    end
  end

end
