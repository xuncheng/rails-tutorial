require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    let(:alice) { FactoryGirl.create(:user) }

    context "with valid email and password" do
      it "redirects to the users#show page" do
        post :create, session: { email: alice.email, password: alice.password }
        expect(response).to redirect_to user_path(alice)
      end

      it "stores the user in the session" do
        post :create, session: { email: alice.email, password: alice.password }
        expect(session[:user_id]).to eq(alice.id)
      end
    end

    context "witn invalid email and password" do
      it "re-renders the sign in page" do
        post :create, session: { email: alice.email, password: alice.password + "abc" }
        expect(response).to render_template :new
      end

      it "assigns the flash with error message" do
        post :create, session: { email: alice.email, password: alice.password + "abc" }
        expect(flash[:error]).to be_present
      end

      it "does not store the user in the session" do
        post :create, session: { email: alice.email, password: alice.password + "abc" }
        expect(session[:id]).to be_nil
      end
    end
  end
end
