# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :icf_member, class: User do
    first_name 'Keith'
    last_name 'Garrod'
    email 'keith@opportunityindiversity.com'
    password 'please'
    password_confirmation 'please'
    confirmed_at Time.now
    icf_member_number '9026152'
    profile_type { FactoryGirl.create(:profile_type, name: "ICF Member") }
  end

  factory :student, class: User do
    first_name 'Max'
    last_name 'Dexter'
    email 'highbeats@gmail.com'
    password 'please'
    password_confirmation 'please'
    confirmed_at Time.now
    graduation_date Time.now + 2.years
    profile_type { FactoryGirl.create(:profile_type, name: 'Student') }
    training_program_id { FactoryGirl.create(:training_program, approval_type: 'ACTP').id }
  end
end
