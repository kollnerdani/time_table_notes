class ChartKickData < ApplicationService
  include WorkingTimesHelper
  def initialize(results, search)
    @results = results
    @search = search
  end
  def call
    get_chart_data
  end

  private

  def get_chart_data
    data = {}
    (@search.start_date.to_date.beginning_of_month..@search.end_date.to_date.end_of_month).each do |date|
      data[date.strftime("%Y-%m-%d")] = total_sum(@results.select { |wt| wt.start_time.to_date == date.to_date })
    end
    data
  end
end
