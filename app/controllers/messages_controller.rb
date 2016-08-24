class MessagesController < ApplicationController
  def index
    @messages = Message.where(conversation_id: params[:conversation_id])
    @message = current_user.messages.build
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    if @message.save
      redirect_to conversation_messages_path(@message.conversation_id)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
