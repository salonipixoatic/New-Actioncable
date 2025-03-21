class ChatsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @chats = current_user.chats
    @users = User.where.not(id: current_user.id) 
  end 

  def new
    @chat = Chat.new
    @users = User.where.not(id: current_user.id) 
  end

  def create
    if params[:chat] && params[:chat][:user_ids].present?
      create_group_chat
    elsif params[:user_id]
      create_one_to_one_chat
    else
      redirect_to chats_path, alert: "Please select a user or create a group."
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.includes(:user)
  end

  private

  def create_one_to_one_chat
    other_user = User.find(params[:user_id])

    chat = Chat.joins(:chat_users)
               .where(chat_users: { user_id: [current_user.id, other_user.id] })
               .group("chats.id")
               .having("COUNT(chat_users.user_id) = 2")
               .first

    unless chat
      chat = Chat.create(name: "One-to-One Chat")
      chat.chat_users.create(user: current_user)
      chat.chat_users.create(user: other_user)
    end

    redirect_to chat_path(chat)
  end

  def create_group_chat
    user_ids = params[:chat][:user_ids].map(&:to_i) 
    user_ids << current_user.id 

    chat = Chat.create(name: params[:chat][:name] || "New Group Chat")
    
    user_ids.each do |user_id|
      chat.chat_users.create(user_id: user_id)
    end

    redirect_to chat_path(chat)
  end
end
