require 'spec_helper'

describe StaticPagesController do
  describe "GET home" do
    context "with signed in user" do
      let(:alice) { FactoryGirl.create(:user) }
      before { set_current_user(alice) }

      it "assigns a new micropost to @micropost" do
        get :home
        expect(assigns(:micropost)).to be_a_new(Micropost)
      end

      it "assigns the micropost that associated with the signed in user" do
        get :home
        expect(assigns(:micropost).user).to eq(alice)
      end

      it "assigns the microposts that associated with the signed in user to @feed_items" do
        micropost1 = FactoryGirl.create(:micropost, user: alice)
        micropost2 = FactoryGirl.create(:micropost)
        get :home
        expect(assigns(:feed_items)).to match_array([micropost1])
      end
    end
  end
end
