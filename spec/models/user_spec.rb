require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  # it { should validate_uniqueness_of(:email) }
  it { should allow_value('asf@jkl').for(:email) }
  it { should_not allow_value('asdfjkl').for(:email) }
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should have_many(:microposts).order('created_at DESC').dependent(:destroy) }

  it "generates a random slug when the user is created" do
    alice = FactoryGirl.create(:user)
    expect(alice.slug).to be_present
  end

  it "changes email address to lowercase characters" do
    alice = FactoryGirl.create(:user, email: "aLice@Example.com")
    expect(alice.email).to eq("alice@example.com")
  end

  it "generates a random remember_token when the user is saved" do
    alice = FactoryGirl.create(:user)
    expect(alice.remember_token).to be_present
  end
end
