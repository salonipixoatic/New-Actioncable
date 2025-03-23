require 'rails_helper'

RSpec.describe ChatsController, type: :controller do 
  include Devise::Test::ControllerHelpers 
  before do
    @user = User.create!(email: "test@example.com", password: "password123")
    @other_user = User.create!(email: "other@example.com", password: "password123")
    @chat = Chat.create!(name: " Something new Chat")

    sign_in @user  
  end

  describe "GET #index" do
    it "all users " do
      get :index
      expect(assigns(:chats)).to eq(@user.chats)
      expect(assigns(:users)).to eq(User.where.not(id: @user.id))
    end
  end

  describe "POST #create" do
    it "create  a one-to-one chat" do
      post :create, params: { user_id: @other_user.id }
      chat = Chat.last 
      expect(response).to redirect_to(chat_path(chat))
    end

    it "creates a group chat and redirects" do
      post :create, params: { chat: { user_ids: [@other_user.id], name: "Test Group" } }
      chat = Chat.last  
      expect(response).to redirect_to(chat_path(chat))
    end
end

  describe "GET #show" do
    it "show requested chat and messages using id " do
      get :show, params: { id: @chat.id }
      expect(assigns(:chat)).to eq(@chat)
    end
  end
end
