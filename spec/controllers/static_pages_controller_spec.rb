require 'spec_helper'

describe StaticPagesController do
  describe "GET home" do
    it "builds a new micropost to @micropost for authenticated user" do
      alice = FactoryGirl.create(:user)
      set_current_user(alice)
      get :home
      expect(assigns(:micropost)).to be_a_new(Micropost)
    end
  end
end
