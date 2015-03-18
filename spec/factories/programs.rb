# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program do
    start_from_date Time.now
    end_date 2.month.from_now
    coaching_media "MyString"
    after_hours_availability "MyString"
    additional_time_text "MyText"
    number_of_sessions 1
    session_duration "MyString"
    hours_notice_of_cancellation "MyText"
    weeks_notice "MyText"
    mediation_period "MyString"
  end
end
