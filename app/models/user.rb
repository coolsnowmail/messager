class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # devise :database_authenticatable, :authentication_keys => [:timezone]
  # validates :timezone, presence: true
  has_one  :profile, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :senders,-> { uniq }, through: :messages
  has_many :service_users, dependent: :destroy
  has_many :services, through: :service_users
end
