class Service < ActiveRecord::Base
	has_many :messages, dependent: :destroy
	has_many :servise_users
	has_many :users, through: :servise_users

end
