require "test_helper"

class WorkingTimeTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @working_time = working_times(:one)
  end

  test "occupied working_time" do
    working_time = WorkingTime.new(user: @user, title: @working_time.title, description: @working_time.description, start_time: @working_time.start_time,  duration: 6)
    assert_not working_time.valid?
  end

  test "valid working_time" do
    working_time = WorkingTime.new(user: @user, title: @working_time.title, description: @working_time.description, date: @working_time.start_time + 1.days, start_time: @working_time.start_time,  duration: 6)
    assert working_time.valid?
  end

  test "presence of all attributes" do
    working_time = WorkingTime.new(user: @user)
    assert_not working_time.valid?
  end

  test "start_time should not be in the past" do
    working_time = WorkingTime.new(user: @user, title: @working_time.title, description: @working_time.description, start_time: @working_time.start_time - 5.minutes, duration: 6)
    assert_not working_time.valid?
  end

  test "end_time should be greater then start_time" do
    working_time = WorkingTime.new(user: @user, title: @working_time.title, description: @working_time.description, start_time: @working_time.start_time,  duration: - 6)
    assert_not working_time.valid?
  end

  test "#is_holiday?" do
    working_time = WorkingTime.new(start_time: "2024-12-25")
    assert working_time.is_holiday?
  end

  test "#is_holiday? false" do
    working_time = WorkingTime.new(start_time: "2024-12-23")
    assert_not working_time.is_holiday?
  end


  test "#holiday_name" do
    working_time = WorkingTime.new(start_time: "2024-12-25")
    assert_equal working_time.holiday_name, I18n.t("christmas")
  end
end
