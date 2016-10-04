class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", dependent: :destroy
  has_many :event_users
  has_many :attendees, through: :event_users, source: :user
  scope :future_events,
        -> { where("happens_at > ?",Time.now).order(:happens_at) }
  scope :past_events,
        -> { where("happens_at < ?",Time.now).order(:happens_at) }

  def attendees_count
    self.attendees.size
  end
end
