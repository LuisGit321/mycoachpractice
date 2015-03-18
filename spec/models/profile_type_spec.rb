require 'spec_helper'

describe ProfileType do
  it { should validate_presence_of :name }
end
