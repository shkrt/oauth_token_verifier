require 'spec_helper'
include ::OauthTokenVerifier

RSpec.describe OauthTokenVerifier do
  it 'has a version number' do
    expect(OauthTokenVerifier::VERSION).not_to be nil
  end
end

RSpec.describe TokenVerifier do
  context 'when correctly configured' do

    before(:each) do
      OauthTokenVerifier.configure do |config|
        config.enabled_providers = [:facebook]
      end
    end

    it 'successfully initializes' do
      verifier = described_class.new(:facebook, 'token')
      expect(verifier).to be_instance_of(TokenVerifier)
      expect(verifier.provider).to be_instance_of(OauthTokenVerifier::Providers::Facebook)
      expect(verifier.token).to eq('token')
    end
  end
end
