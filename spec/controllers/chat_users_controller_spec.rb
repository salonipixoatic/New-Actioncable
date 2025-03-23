require 'rails_helper'

RSpec.describe ChatUsersController, type: :controller do
  include Devise::Test::ControllerHelpers  

  before do
    @user = User.create!(email: "test@example.com", password: "password123")
    @chat = Chat.create!(name: "testchat")

    sign_in @user 
  end

  describe "POST #create" do
    it "adds the current user to the chat" do
      expect {
        post :create, params: { chat_id: @chat.id }
      }.to change { @chat.chat_users.count }.by(1)  

      expect(@chat.chat_users.exists?(user_id: @user.id)).to be true 
      expect(response).to redirect_to(@chat) 
    end
  end
end
