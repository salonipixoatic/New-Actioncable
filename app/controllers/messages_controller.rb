class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.create(user: current_user, content: params[:message][:content])

    if @message.persisted?
      ChatChannel.broadcast_to(@chat, {
        user: @message.user.email,
        content: @message.content
      })
      head :no_content 
    else
      render json: { error: "Message not sent" }, status: :unprocessable_entity
    end
  end 

end  

