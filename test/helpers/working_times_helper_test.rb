require "test_helper"

class WorkingTimesHelperTest < ActiveSupport::TestCase
  include WorkingTimesHelper
  test "#total_sum" do
    assert_equal total_sum(working_times), 2.0
  end

  test "#is_holiday?" do
    assert is_holiday?("2024-01-01")
  end

  test "#is_holiday? false" do
    assert_not is_holiday?("2024-01-02")
  end

  test "#holiday_name" do
    assert_equal holiday_name("2024-12-25"), I18n.t("christmas")
  end

  test "#get_capacity" do
    working_time = WorkingTime.new(start_time: "2024-01-02 8:00", end_time: "2024-01-02 10:00")
    assert_equal get_capacity(Array(working_time), "daily_index"), 25.0
  end
end
