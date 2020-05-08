class Event < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  scope :past, -> { where("date < ?", DateTime.now) }
  scope :upcoming, -> { where("date > ?", DateTime.now) }
  
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :attendees, through: :event_attendances, source: :attendee
  has_many :event_attendances, foreign_key: :attended_event_id
end
