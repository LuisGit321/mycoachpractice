require 'spec_helper'

describe User do
  it { should have_field(:training_program_id) }
  it { should have_field(:graduation_date) }

  it { should belong_to :profile_type }
  it { should have_many :proposals }
  it { should have_many :leads }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }

  describe "icf membership"
    it "validates icf member number" do
      icf_member = FactoryGirl.build(:icf_member) do |user|
        user.icf_member_number = nil
      end

      icf_member.should_not be_valid
    end

    it "adds errors in case icf credentials do not match" do
      attrs_invalid = ["example@example.com", "Smith"]

      icf_member = FactoryGirl.build(:icf_member) do |u|
        u.email        = attrs_invalid[0]
        u.last_name    = attrs_invalid[2]
      end

      icf_member.should_not be_valid
      icf_member.errors[:email].should_not be_nil
      icf_member.errors[:last_name].should_not be_nil
    end
  end

  describe "student" do

    it "should validate presence of training program" do
      student = FactoryGirl.build(:student) do |student|
        student.training_program_id = nil
      end
      student.should_not be_valid
    end

    it "should validate presence of graduation date" do
      student = FactoryGirl.build(:student) do |student|
        student.graduation_date =nil
      end

      student.should_not be_valid
    end

    it "should email confirmation request to training provider" do
      student = FactoryGirl.create(:student)
      training_provider_email = student.training_program.training_provider.email
      student.request_provider_confirmation

      ActionMailer::Base.deliveries.should_not be_empty
      student.provider_confirmation_sent_at.should_not be_nil
    end

  end
