class Event < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :attendances, foreign_key: :attended_event_id

  validates :date, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true


  scope :past, ->{ where("date < ?", Time.now).order("date desc") }
  scope :upcoming, ->{ where("date > ?", Time.now).order("date asc") }

  def past?
  	date < Time.now
  end

  def upcoming?
  	date >= Time.now
  end

=begin suppress for now while seeding on heroku
  validate :in_the_future, on: :create
  def in_the_future
    if date < Time.now
      errors.add(:date, "has already passed")
    end
  end
=end
end