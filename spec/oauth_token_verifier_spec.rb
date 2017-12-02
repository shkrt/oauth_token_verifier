require 'spec_helper'
include ::OauthTokenVerifier

RSpec.describe OauthTokenVerifier do
  it 'has a version number' do
    expect(OauthTokenVerifier::VERSION).not_to be nil
  end

  describe '#configure' do
    it 'yields to block' do
      expect(described_class.configure { |config| 2 + 2 }).to eq 4
    end
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

    it 'it delegates verify_token to provider class' do
      verifier = described_class.new(:facebook, 'token')
      fb = verifier.provider
      allow(fb).to receive(:verify_token).and_return(:something)
      expect(fb).to receive(:verify_token).with(verifier)
      verifier.verify_token
    end
  end

  context 'when specified provider missing from configuration' do
    before(:each) do
      OauthTokenVerifier.configure do |config|
        config.enabled_providers = []
      end
    end

    it 'raises configuration error during initialization' do
      expect { described_class.new(:facebook, 'token') }.to raise_error(
        OauthTokenVerifier::TokenVerifier::NoProviderFoundError
      )
    end
  end
end
