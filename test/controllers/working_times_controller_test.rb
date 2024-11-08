require "test_helper"

class WorkingTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @working_time = working_times(:one)
    sign_in users(:one)
    @working_time_params = { working_time: { description: @working_time.description,
                                             duration: 1, date: @working_time.start_time + 1.days,
                                             start_time: @working_time.start_time, title: @working_time.title,
                                             user_id: @working_time.user_id } }
  end

  test "should get index" do
    get working_times_url
    assert_response :success
  end

  test "should get daily index" do
    get daily_index_working_times_url
    assert_response :success
  end

  test "should get weekly index" do
    get weekly_index_working_times_url
    assert_response :success
  end

  test "should get new" do
    get new_working_time_url
    assert_response :success
  end

  test "should create working_time" do
    assert_difference("WorkingTime.count") do
      post working_times_url, params: @working_time_params
    end

    assert_redirected_to working_time_url(WorkingTime.last)
  end

  test "should show working_time" do
    get working_time_url(@working_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_working_time_url(@working_time)
    assert_response :success
  end

  test "should update working_time" do
    patch working_time_url(@working_time), params: @working_time_params
    assert_redirected_to working_time_url(@working_time)
  end

  test "should destroy working_time" do
    assert_difference("WorkingTime.count", -1) do
      delete working_time_url(@working_time)
    end

    assert_redirected_to working_times_url
  end
end
