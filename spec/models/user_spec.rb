require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  # it { should validate_uniqueness_of(:email) }
  it { should allow_value('asf@jkl').for(:email) }
  it { should_not allow_value('asdfjkl').for(:email) }
  it { should ensure_length_of(:password).is_at_least(6) }
end
