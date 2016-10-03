class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :sender
  belongs_to :service
  validates :sender_id, presence: true
  validates :user_id, presence: true
  scope :for_sender, -> (color) { where(sender_id: color) }
end
