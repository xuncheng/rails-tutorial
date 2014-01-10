require 'spec_helper'

describe UsersController do
  describe "GET index" do
    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end

    it "populates an array of users" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      set_current_user(user1)
      get :index
      expect(assigns(:users)).to match_array([user1, user2])
    end
  end

  describe "GET new" do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET show" do
    let(:alice) { FactoryGirl.create(:user) }

    it "assigns the requested user to @user" do
      get :show, id: alice.slug
      expect(assigns(:user)).to eq(alice)
    end

    it "assigns the microposts to @microposts that associated with the user" do
      micropost1 = FactoryGirl.create(:micropost, user: alice)
      micropost2 = FactoryGirl.create(:micropost, user: alice)
      get :show, id: alice.slug
      expect(assigns(:microposts)).to match_array([micropost1, micropost2])
    end
  end

  describe "GET edit" do
    let(:alice) { FactoryGirl.create(:user, email: "right@example.com") }
    let(:another_user) { FactoryGirl.create(:user, email: "wrong@example.com") }

    before { set_current_user(alice) }

    it_behaves_like "requires sign in" do
      let(:action) { get :edit, id: alice.slug }
    end

    it_behaves_like "requires correct user" do
      let(:action) { get :edit, id: another_user.slug }
    end

    it "assigns the requested user to @user" do
      get :edit, id: alice.slug
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

      it "stores the user in the cookies" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(cookies[:remember_token]).to eq(assigns(:user).remember_token)
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

  describe "PUT update" do
    let(:alice) { FactoryGirl.create(:user, name: "John Smith") }
    let(:another_user) { FactoryGirl.create(:user, email: "wrong@example.com") }

    before { set_current_user(alice) }

    it_behaves_like "requires sign in" do
      let(:action) { put :update, id: alice.slug, user: FactoryGirl.attributes_for(:user) }
    end

    it_behaves_like "requires correct user" do
      let(:action) { get :edit, id: another_user.slug }
    end

    context "with valid attributes" do
      it "redirects to the updated user page" do
        put :update, id: alice.slug, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to user_path(alice)
      end

      it "located the requested user to @user" do
        put :update, id: alice.slug, user: FactoryGirl.attributes_for(:user)
        expect(assigns(:user)).to eq(alice)
      end

      it "changes the user's attributes" do
        put :update, id: alice.slug, user: FactoryGirl.attributes_for(:user, name: "Rails Tutorial")
        expect(alice.reload.name).to eq("Rails Tutorial")
      end

      it "assigns the flash with success message" do
        put :update, id: alice.slug, user: FactoryGirl.attributes_for(:user)
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid attributes" do
      it "re-renders the :edit template" do
        put :update, id: alice.slug, user: { name: nil }
        expect(response).to render_template :edit
      end

      it "does not change the user's attributes" do
        put :update, id: alice.slug, user: FactoryGirl.attributes_for(:user, name: nil)
        expect(alice.reload.name).to eq("John Smith")
      end
    end
  end

  describe "DELETE destroy" do
    let(:admin) { FactoryGirl.create(:admin) }

    before { set_current_user(admin) }

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: FactoryGirl.create(:user).slug }
    end

    it_behaves_like "requires admin" do
      let(:action) { delete :destroy, id: FactoryGirl.create(:user).slug }
    end

    it "redirects to the all users page" do
      delete :destroy, id: FactoryGirl.create(:user).slug
      expect(response).to redirect_to users_url
    end

    it "deletes the user from the database" do
      user = FactoryGirl.create(:user)
      expect{
        delete :destroy, id: user.slug
      }.to change(User, :count).by(-1)
    end

    it "shows the flash success messages" do
      delete :destroy, id: FactoryGirl.create(:user).slug
      expect(flash[:success]).to be_present
    end

    it "does not delete the user if the user is itself" do
      expect{
        delete :destroy, id: admin.slug
      }.not_to change(User, :count)
    end
  end
end
