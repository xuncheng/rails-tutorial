require 'spec_helper'

describe MicropostsController do
  describe "POST create" do
    let(:alice) { FactoryGirl.create(:user) }
    before { set_current_user(alice) }

    it_behaves_like "requires sign in" do
      let(:action) { post :create, micropost: FactoryGirl.attributes_for(:micropost) }
    end

    context "with valid content" do
      it "redirects to the home page" do
        post :create, micropost: FactoryGirl.attributes_for(:micropost)
        expect(response).to redirect_to root_url
      end

      it "saves a new micropost in the database" do
        expect{
          post :create, micropost: FactoryGirl.attributes_for(:micropost)
        }.to change(Micropost, :count).by(1)
      end

      it "saves the micropost that is associated with the signed in user" do
        post :create, micropost: FactoryGirl.attributes_for(:micropost)
        expect(assigns(:micropost).user).to eq(alice)
      end

      it "shows the flash success messages" do
        post :create, micropost: FactoryGirl.attributes_for(:micropost)
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid content" do
      it "re-renders the home page" do
        post :create, micropost: FactoryGirl.attributes_for(:micropost, content: nil)
        expect(response).to render_template 'static_pages/home'
      end

      it "does not save the new micropost in the database" do
        expect{
          post :create, micropost: FactoryGirl.attributes_for(:micropost, content: nil)
        }.not_to change(Micropost, :count)
      end
    end
  end
end
