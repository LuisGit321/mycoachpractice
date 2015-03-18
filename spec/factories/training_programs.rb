# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :training_program do
    name "Program1"
    approval_type "ACTP"
    training_provider { FactoryGirl.create(:training_provider) }
  end
end
