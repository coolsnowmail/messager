class Sender < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
  validates :user_id, presence: true
  validates :name, uniqueness: { scope: :user_id, message: I18n.t("notice_that_this_sender_name_have_been_acupate") }
end
