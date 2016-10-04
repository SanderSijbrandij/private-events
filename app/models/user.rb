class User < ApplicationRecord
  has_many :created_events, class_name: "Event", foreign_key: "creator"
  has_many :event_users
  has_many :attended_events, through: :event_users, source: :event
  before_save :downcase_email
  has_secure_password

  def future_events
    self.attended_events.future_events
  end

  def past_events
    self.attended_events.past_events
  end

  def created_events
     Event.where(creator_id: self.id)
  end

  private

  def downcase_email
    email.downcase!
  end
end
