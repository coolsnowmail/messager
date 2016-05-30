class User < ActiveRecord::Base
	has_one  :profile, dependent: :destroy
	has_many :messages, dependent: :destroy
	has_many :servise_users
	has_many :services, through: :servise_users
end
