class User < ActiveRecord::Base
	has_one :profile
	has_many :messages
	has_many :services through: :service_user
end
