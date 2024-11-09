class WorkingTimesController < ApplicationController
  before_action :set_working_time, only: %i[ show edit update destroy ]

  # GET /working_times or /working_times.json
  def index
    @start_date = params[:start_date].present? ? params[:start_date].to_date : Date.current
    @working_times = current_user.working_times.where(start_time: @start_date.beginning_of_month..(@start_date.end_of_month + 1.day)).order(start_time: :asc)
  end

  def daily_index
    @day = params[:day].present? ? params[:day].to_date : Date.current
    @working_times = current_user.working_times.where(start_time: @day.beginning_of_day..@day.end_of_day).order(start_time: :asc)
  end

  def weekly_index
    @day = params[:start_date].present? ? params[:start_date].to_date : Date.current
    @working_times = current_user.working_times.where(start_time: @day.beginning_of_week..(@day.end_of_day + 1.days)).order(start_time: :asc)
  end

  # GET /working_times/1 or /working_times/1.json
  def show
  end

  # GET /working_times/new
  def new
    @working_time = WorkingTime.new(date: params[:date].present? ? params[:date].to_date : Date.current)
  end

  # GET /working_times/1/edit
  def edit
  end

  # POST /working_times or /working_times.json
  def create
    @working_time = WorkingTime.new(working_time_params)
    @working_time.user = current_user
    respond_to do |format|
      if @working_time.save
        format.html { redirect_to @working_time, notice: t("successfully_created") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /working_times/1 or /working_times/1.json
  def update
    respond_to do |format|
      if @working_time.update(working_time_params)
        format.html { redirect_to @working_time, notice: t("successfully_updated") }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /working_times/1 or /working_times/1.json
  def destroy
    @working_time.destroy!

    respond_to do |format|
      format.html { redirect_to working_times_path, status: :see_other, notice: t("successfully_destroyed") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_working_time
      @working_time = WorkingTime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def working_time_params
      params.require(:working_time).permit(:start_time, :end_time, :title, :description, :duration, :date)
    end
end
