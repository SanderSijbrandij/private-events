class User < ApplicationRecord
  has_many :created_events, class_name: "Event", foreign_key: "creator"
  before_save :downcase_email
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
