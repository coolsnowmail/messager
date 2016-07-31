class Sender < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :users,-> { uniq }, through: :messages
  validates :name, presence: true
end
