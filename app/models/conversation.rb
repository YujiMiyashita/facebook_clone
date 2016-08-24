class Conversation < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'User'

  validates_uniqueness_of :sender_id, scope: :recipient_id
end
