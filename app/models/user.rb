class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one  :profile, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :service_users
  has_many :services, through: :service_users

  # def test3
  #   puts "test"  	
  # end

  # def self.test2
  # 	puts "test2"  	
  # end

end
