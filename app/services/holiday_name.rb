class HolidayName < ApplicationService
  def initialize(date)
    @date = date
  end
  def call
    Holidays.on(@date, :hu).last[:name]
  end
end
