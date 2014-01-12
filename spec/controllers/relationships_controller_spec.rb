require 'spec_helper'

describe RelationshipsController do
  describe "POST create" do
    let(:alice) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    before { set_current_user(alice) }

    it_behaves_like "requires sign in" do
      let(:action) { post :create, followed_id: "abc" }
    end

    it "redirects to the followed user page" do
      post :create, followed_id: other_user.slug
      expect(response).to redirect_to user_path(other_user)
    end

    it "saves a relationship that the signed in user follows the user" do
      expect{
        post :create, followed_id: other_user.slug
      }.to change(alice.relationships, :count).by(1)
    end

    it "does not save a relationship if the current user already followed the user" do
      alice.follow!(other_user)
      expect{
        post :create, followed_id: other_user.slug
      }.not_to change(alice.relationships, :count)
    end

    it "does not allow the signed in user to follow themselves" do
      expect{
        post :create, followed_id: alice.slug
      }.not_to change(alice.relationships, :count)
    end
  end

  describe "DELETE destroy" do
    let(:alice) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    before { set_current_user(alice) }

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: "abc" }
    end

    it "redirects to the follower page" do
      relationship = alice.relationships.create(followed: other_user)
      delete :destroy, id: relationship.id
      expect(response).to redirect_to user_path(other_user)
    end

    it "deletes the relationship if the signed in user is the follower" do
      relationship = alice.relationships.create(followed: other_user)
      expect{
        delete :destroy, id: relationship.id
      }.to change(alice.followed_users, :count).by(-1)
    end

    it "does not delete the relationship if the signed in user is not the follower" do
      bob = FactoryGirl.create(:user)
      relationship = bob.relationships.create(followed: other_user)
      expect{
        delete :destroy, id: relationship.id
      }.not_to change(alice.followed_users, :count)
    end
  end
end
