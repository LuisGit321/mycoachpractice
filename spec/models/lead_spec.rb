require 'spec_helper'

describe Lead do
  it { should have_field(:coach_id) }
  it { should have_field(:rpf_id) }
  it { should have_field(:created_at) }
  it { should have_field(:proposal_sent_at) }

  it { should validate_presence_of(:coach_id) }
  it { should validate_presence_of(:rpf_id) }

  it { should belong_to(:coach).of_type(User) }
end
