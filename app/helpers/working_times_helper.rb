module WorkingTimesHelper
  def total_sum(working_times)
    working_times.sum { |working_time| working_time.total_duration } / 60
  end

  def is_holiday?(date)
    IsHoliday.call(date)
  end

  def holiday_name(date)
    HolidayName.call(date)
  end
end
