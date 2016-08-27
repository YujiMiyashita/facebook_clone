class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.where(conversation_id: params[:conversation_id]).order(created_at: :desc).reverse_order
    @message = current_user.messages.build(conversation_id: params[:conversation_id])
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
