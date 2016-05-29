class Message < ActiveRecord::Base
	attr_accessible :user, :user_id
	# belongs_to :service
	# belongs_to :sender
	# belongs_to :user
	belongs_to :user


end
