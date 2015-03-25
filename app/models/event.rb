class Event < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :attendances

  default_scope { order("date desc") }
  scope :past, ->{ where("date < ?", Time.now).order("date asc") }
  scope :upcoming, ->{ where("date > ?", Time.now).order("date desc") }

  def past?
  	date < Time.now
  end

  def upcoming?
  	date >= Time.now
  end
end
