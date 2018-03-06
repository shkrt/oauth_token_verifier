require 'spec_helper'

RSpec.describe 'Vk interaction' do
  it 'returns error without correct access token', vcr: true do
    VCR.use_cassette("vk_no_token") do
      response = Net::HTTP.get_response(URI("https://api.vk.com/method/users.get?access_token=incorrect_token&v=5.0"))
      response_body = JSON.parse(response.body)
      expect(response_body['error']['error_code']).to eq 5
      expect(response_body['error']['error_msg']).to eq 'User authorization failed: invalid access_token (4).'
    end
  end
end
