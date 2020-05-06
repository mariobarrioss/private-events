class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :attendees, through: :event_attendances, source: :attendee
  has_many :event_attendances, foreign_key: :attended_event_id
end
