# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :proposal do
    coach { FactoryGirl.create(:icf_member) }
    created_at Time.now
  end
end
