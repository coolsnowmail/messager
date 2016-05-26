class Service < ActiveRecord::Base
	has_many :service_users
	has_many :messages
end
