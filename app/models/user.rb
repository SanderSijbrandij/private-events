class User < ApplicationRecord
  has_many :created_events, class_name: "Event", foreign_key: "creator"
  has_many :event_users
  has_many :attended_events, through: :event_users, source: :event
  before_save :downcase_email
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
