require 'spec_helper'

RSpec.describe 'Fb interaction' do
  it 'returns error without correct access token', vcr: true do
    VCR.use_cassette("fb_no_token") do
      response = Net::HTTP.get_response(URI("https://graph.facebook.com/me?access_token=incorrect_token"))
      response_body = JSON.parse(response.body)
      expect(response_body['error']['message']).to eq 'Invalid OAuth access token.'
      expect(response_body['error']['code']).to eq 190
      expect(response_body['error']['type']).to eq 'OAuthException'
    end
  end
end
