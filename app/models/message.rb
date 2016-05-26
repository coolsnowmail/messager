class Message < ActiveRecord::Base
	belongs_to :service
	belongs_to :sender
	belongs_to :user 
end
