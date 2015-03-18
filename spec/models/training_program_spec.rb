require 'spec_helper'

describe TrainingProgram do

  it { should have_field(:language) }
  it { should be_embedded_in(:training_provider) }
  it { should have_many(:students).of_type(User) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:approval_type) }
# it { should validate_presence_of(:description) }

end
