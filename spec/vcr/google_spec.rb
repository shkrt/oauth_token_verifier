require 'spec_helper'

RSpec.describe 'Google interaction', vcr: true do
  it 'returns error without correct access token' do
    VCR.use_cassette("google_no_token") do
      response = Net::HTTP.get_response(URI("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=incorrect_token"))
      response_body = JSON.parse(response.body)
      expect(response_body['error_description']).to eq 'Invalid Value'
    end
  end
end
