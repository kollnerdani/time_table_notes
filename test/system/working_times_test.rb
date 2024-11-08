require "application_system_test_case"

class WorkingTimesTest < ApplicationSystemTestCase
  setup do
    @working_time = working_times(:one)
    sign_in users(:one)
  end

  test "visiting the index" do
    visit working_times_url
    assert_selector "h1", text: I18n.t("activerecord.model.working_time")
  end

  test "visiting the weekly_index" do
    visit weekly_index_working_times_url
    assert_selector ".calendar-tag", text: I18n.t("weekly", week: Date.today.cweek)
  end

  test "visiting the daily_index" do
    visit daily_index_working_times_url
    assert_selector ".calendar-tag", text: I18n.t("daily", day: Date.today)
  end

  test "should create working time" do
    visit working_times_url
    all(class: "button-primary").last.click

    fill_with
    click_on I18n.t("create")

    assert_text I18n.t("successfully_created")
    click_on I18n.t("back")
  end

  test "should update Working time" do
    visit working_time_url(@working_time)
    click_on I18n.t("edit"), match: :first

    fill_with
    click_on I18n.t("update")
    assert_text I18n.t("successfully_updated")
    click_on I18n.t("back")
  end

  test "should destroy Working time" do
    visit working_time_url(@working_time)
    click_on I18n.t("destroy"), match: :first

    assert_text I18n.t("successfully_destroyed")
  end

  test "search" do
    visit working_times_url
    fill_in "search[start_date]", with: Date.today.beginning_of_month
    fill_in "search[end_date]", with: Date.today.end_of_month

    click_on I18n.t("search")
    assert_text "#{I18n.t("total_sum")} #{working_times(:one).total_duration / 60 }"
  end

  def fill_with
    fill_in I18n.t("activerecord.attributes.working_time.description"), with: @working_time.description
    select I18n.t("hour", hour: 7), from: I18n.t("activerecord.attributes.working_time.duration")
    select (Time.zone.now + 1.hours).hour, from: "working_time_start_time_4i"
    fill_in I18n.t("activerecord.attributes.working_time.title"), with: @working_time.title
  end
end
