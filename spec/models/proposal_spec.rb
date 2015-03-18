require 'spec_helper'

describe Proposal do
  it { should belong_to(:coach).of_type(User) }
  it { should embed_one(:program) }

  subject do
    FactoryGirl.create(:proposal, lead: FactoryGirl.create(:lead), coach: FactoryGirl.create(:icf_member))
  end

end
