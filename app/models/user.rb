class User < ApplicationRecord
  has_many :events, foreign_key: :creator_id
  has_many :event_attendances, foreign_key: :attendee_id
  has_many :attended_events, through: :event_attendances, source: :attended_event
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :set_default_password

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  private

  def set_default_password
    self.password = 'password'
    self.password_confirmation = 'password'
  end

end
