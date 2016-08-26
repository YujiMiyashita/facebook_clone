class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friend_users = current_user.friend
    @conversation = Conversation.new
  end

  def create
    if find_conversation
      redirect_to conversation_messages_path(find_conversation)
    else
      @conversation = Conversation.new(conversation_params)
      @conversation.sender_id = current_user.id
      @conversation.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def find_conversation
    sender = Conversation.find_by(sender_id: current_user.id, recipient_id: params[:conversation][:recipient_id])
    recipient = Conversation.find_by(sender_id: params[:conversation][:recipient_id] ,recipient_id: current_user.id)
    conversation = sender || recipient
  end

  def conversation_params
    params.require(:conversation).permit(:sender_id, :recipient_id)
  end

end
