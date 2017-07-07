require 'spec_helper'
require "shared_examples/oauth_provider_client"
require 'support/webmock_stub_helper'

RSpec.describe 'OauthTokenVerifier::Providers::Google' do
  describe '#verify_token' do
    it_behaves_like "oauth_provider_client", :google
  end
end
