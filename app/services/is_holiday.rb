class IsHoliday < ApplicationService
  def initialize(date)
    @date = date
  end
  def call
    Holidays.on(@date, :hu).present?
  end
end
