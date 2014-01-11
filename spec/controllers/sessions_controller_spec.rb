require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    let(:alice) { FactoryGirl.create(:user) }

    context "with valid email and password" do
      it "redirects to the home page if non-exisiting return_to in the session" do
        session[:return_to] = nil
        post :create, session: { email: alice.email, password: alice.password }
        expect(response).to redirect_to root_url
      end

      it "redirects to the last visited page if exisiting return_to in the session" do
        session[:return_to] = edit_user_path(alice)
        post :create, session: { email: alice.email, password: alice.password }
        expect(response).to redirect_to edit_user_path(alice)
      end

      it "stores the user in the cookies" do
        post :create, session: { email: alice.email, password: alice.password }
        expect(cookies[:remember_token]).to eq(alice.remember_token)
      end

      it "assigns the flash with success message" do
        post :create, session: { email: alice.email, password: alice.password }
        expect(flash[:success]).to be_present
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

      it "does not store the user in the cookies" do
        post :create, session: { email: alice.email, password: alice.password + "abc" }
        expect(cookies[:remember_token]).to be_nil
      end
    end
  end

  describe "DELETE destroy" do
    before { set_current_user }

    it "redirects to the homepage" do
      delete :destroy
      expect(response).to redirect_to root_url
    end

    it "clears the user in the cookies" do
      delete :destroy
      expect(cookies[:remember_token]).to be_nil
    end

    it "assigns the flash with success message" do
      delete :destroy
      expect(flash[:success]).to be_present
    end
  end
end
