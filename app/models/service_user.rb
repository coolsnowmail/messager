class ServiceUser < ActiveRecord::Base
  belongs_to :service
  belongs_to :user
  has_many :time_service
end
