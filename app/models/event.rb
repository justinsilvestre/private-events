class Event < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :attendances

  validates :date, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true

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