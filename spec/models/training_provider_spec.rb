require 'spec_helper'

describe TrainingProvider do

  it { should embed_many(:training_programs) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
# it { should validate_presence_of(:description) }

  describe ".actp_programs" do
    it "returns array of programs with approval type ACTP" do
      TrainingProvider.actp_programs.each do |p|
        p.approval_type.should == "ACTP"
      end
    end
  end

end
