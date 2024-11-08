class SearchTest < ActiveSupport::TestCase
  test "missing parameters" do
    search = Search.new(start_date: nil, end_date: nil)

    assert search.invalid?
  end

  test "end date can not be bigger then start time" do
    search = Search.new(start_date: Date.today, end_date: Date.today - 1.days)

    assert search.invalid?
  end

  test "#results" do
    search = Search.new(start_date: working_times(:one).start_time.beginning_of_month, end_date: working_times(:one).start_time.end_of_month)

    assert_equal users(:one).working_times, search.results(users(:one))
  end
end
