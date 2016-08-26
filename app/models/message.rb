class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  validates_presence_of :conversation_id, :user_id
  validates :content, presence: true

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
