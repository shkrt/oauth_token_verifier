module OauthTokenVerifier
  RSpec.shared_context "oauth_provider_client" do |provider|
    before do
      OauthTokenVerifier.configure do |config|
        config.enabled_providers = [:vk, :facebook, :google]
      end

      stub_vk_request
      stub_vk_request_with_incorrect_token
      stub_fb_request
      stub_fb_request_with_incorrect_token
      stub_google_request
      stub_google_request_with_incorrect_token
    end

    context "with correct access token" do
      it "returns Struct containing user data" do
        response = TokenVerifier.new(provider, 'correct_token').verify_token
        expect(response).to respond_to(:uid)
        expect(response).to respond_to(:info)
        expect(response).to respond_to(:provider)
      end
    end

    context "with incorrect access token" do
      it "returns error message" do
        response = TokenVerifier.new(provider, 'incorrect_token').verify_token
        expect(response).to respond_to(:uid)
      end
    end
  end
end
