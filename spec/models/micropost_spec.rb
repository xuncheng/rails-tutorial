require 'spec_helper'

describe Micropost do
  it { should belong_to(:user) }
  it { should validate_presence_of(:content) }
  it { should ensure_length_of(:content).is_at_most(140) }
end
