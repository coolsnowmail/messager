class Sender < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
  validates :user_id, presence: true
  validates :name, uniqueness: { scope: :user_id, message: "Данное имя уже занято для этого пользователя" }
end
