class User < ActiveRecord::Base
	has_one  :profile, dependent: :destroy
	has_many :messages, dependent: :destroy
	# has_many :services through: :service_user
end
