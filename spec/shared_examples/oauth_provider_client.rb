module OauthTokenVerifier
  RSpec.shared_context "oauth_provider_client" do |provider|
    context "with correct access token" do
      before do
        OauthTokenVerifier.configure do |config|
          config.enabled_providers = [:vk, :facebook, :google]
        end

        response = TokenVerifier.new(provider, 'correct_token').verify_token
      end

      it "returns Struct containing user data" do


      end
    end
  end
end
