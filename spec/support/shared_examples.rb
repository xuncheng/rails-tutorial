shared_examples "requires sign in" do
  it "redirects to the sign in page" do
    cookies[:remember_token] = nil
    action
    expect(response).to redirect_to sign_in_path
  end
end

shared_examples "requires correct user" do
  it "redirects to the root page" do
    action
    expect(response).to redirect_to root_url
  end
end

shared_examples "requires admin" do
  it "redirects to the root page" do
    set_current_user
    action
    expect(response).to redirect_to root_url
  end
end
