class Attendance < ActiveRecord::Base
  belongs_to :attendee, class_name: 'User'
  belongs_to :attended_event, class_name: 'Event'
  validates :attendee_id, presence: true, uniqueness: { scope: :attended_event_id }
  validates :attended_event_id, presence: true
end
