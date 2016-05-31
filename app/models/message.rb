class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :sender
  belongs_to :service

end
