module WorkingTimesHelper
  def total_sum(working_times)
    (working_times.sum { |working_time| working_time.total_duration } / 60).round(2)
  end

  def is_holiday?(date)
    IsHoliday.call(date)
  end

  def holiday_name(date)
    HolidayName.call(date)
  end

  def get_capacity(events, action)
    return 0 if events.empty?
    total_sum(events.select { |event| !event.not_working_day? }) / (calculate_working_days(events.first.start_time.to_date, action) * 8) * 100
  end

  private
  def calculate_working_days(date, action)
    return 1 if action == "daily_index"
    return (date.beginning_of_week..date.end_of_week).to_a.reject { |d| is_holiday?(d) || [ 0, 6 ].include?(d.wday) }.count if action == "weekly_index"
    (date.beginning_of_month..date.end_of_month).to_a.reject { |d| is_holiday?(d) || [ 0, 6 ].include?(d.wday) }.count
  end
end
