class Search
  include ActiveModel::Model
  include ActiveModel::Validations
  attr_accessor :start_date, :end_date
  validates :start_date, :end_date, presence: true, allow_blank: false
  validates :end_date, comparison: { greater_than: :start_date }, if: :start_date

  def initialize(start_date:, end_date:)
    @start_date = start_date
    @end_date = end_date
  end

  def results(user)
    user.working_times.where(start_time: @start_date.to_date..(@end_date.to_date + 1.days)).order(:start_time)
  end
end
