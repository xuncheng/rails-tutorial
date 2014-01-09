require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET show" do
    it "assigns the requested user to @user" do
      alice = FactoryGirl.create(:user)
      get :show, id: alice.slug
      expect(assigns(:user)).to eq(alice)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "redirects to the users#show page" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to user_path(assigns[:user])
      end

      it "saves the new user in the database" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "shows the flash success messages" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid attributes" do
      it "re-renders the :new template" do
        post :create, user: FactoryGirl.attributes_for(:user, email: nil)
        expect(response).to render_template :new
      end

      it "does not save the new user in the database" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user, email: nil)
        }.not_to change(User, :count)
      end
    end
  end
end
