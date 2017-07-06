require 'spec_helper'

RSpec.describe OauthTokenVerifier do
  it 'has a version number' do
    expect(OauthTokenVerifier::VERSION).not_to be nil
  end
end
