class WorkingTime < ApplicationRecord
  belongs_to :user
  attr_accessor :duration, :date
  before_validation :set_start_time, if: :start_time
  before_validation :set_end_time, if: :duration
  validates :start_time, :duration, :title, :description, :title, presence: true, allow_blank: false
  validates :start_time, comparison: { greater_than: Time.zone.now }
  validates :end_time, comparison: { greater_than: :start_time }
  validate :start_time_and_end_time_are_free

  def is_holiday?
    IsHoliday.call(start_time)
  end

  def holiday_name
    Holidays.on(start_time, :hu).last[:name]
  end

  def start_time_and_end_time_are_free
    errors.add(:end_time, :occupied) unless WorkingTime.where(start_time: start_time..end_time).or(WorkingTime.where(end_time: start_time..end_time)).empty? || (id && WorkingTime.where(start_time: start_time..end_time).or(WorkingTime.where(end_time: start_time..end_time)).last.id == id)
  end

  def total_duration
    (end_time - start_time) / 60
  end

  private

  def set_end_time
    self.end_time = self.start_time + self.duration.to_i.hours
  end

  def set_start_time
    self.start_time = DateTime.parse("#{self.date} #{self.start_time.to_fs(:time)}")
  end
end
