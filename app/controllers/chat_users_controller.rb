class ChatUsersController < ApplicationController
   before_action :authenticate_user!
   before_action :set_chat
 
   def create
     @chat_user = @chat.chat_users.where(user_id: current_user.id).first_or_create
     redirect_to @chat
   end
 
   private
 
   def set_chat
     @chat = Chat.find(params[:chat_id])
   end
end
