# frozen_string_literal: true

def stub_fb_request
  WebMock.stub_request(:get, /https:\/\/graph\.facebook\.com\/me\?access_token=correct_token*./)
         .with(headers: { 'Accept' => '*/*', 'Host' => 'graph.facebook.com', 'User-Agent' => 'Ruby' })
         .to_return(status: 200, body: '{"name":"Name S.","id":"11111"}', headers: {})
end

def stub_fb_request_with_incorrect_token
  WebMock.stub_request(:get, /https:\/\/graph\.facebook\.com\/me\?access_token=incorrect_token*./)
         .with(headers: { 'Accept' => '*/*', 'Host' => 'graph.facebook.com', 'User-Agent' => 'Ruby' })
         .to_return(status: 200, body: '{"error":{"message":"Error description"}')
end

def stub_vk_request
  WebMock.stub_request(:get, /https:\/\/api\.vk\.com\/method\/users\.get\?access_token=correct_token*./)
         .with(headers: { 'Accept' => '*/*', 'Host' => 'api.vk.com', 'User-Agent' => 'Ruby' })
         .to_return(status: 200,
                    body: '{"response":[{"uid":"010101","first_name":"Name","last_name":"Surname"}]}',
                    headers: {})
end

def stub_vk_request_with_incorrect_token
  WebMock.stub_request(:get, /https:\/\/api\.vk\.com\/method\/users\.get\?access_token=incorrect_token*./)
         .with(headers: { 'Accept' => '*/*', 'Host' => 'api.vk.com', 'User-Agent' => 'Ruby' })
         .to_return(status: 200,
                    body: '{"error":{"error_msg":"Error description"}}',
                    headers: {})
end

def stub_google_request
  WebMock.stub_request(:get, /https:\/\/www\.googleapis\.com\/oauth2\/v3\/tokeninfo\?id_token=correct_token/)
         .with(headers: { 'Accept' => '*/*', 'Host' => 'www.googleapis.com', 'User-Agent' => 'Ruby' })
         .to_return(status: 200, body: '{"azp":"","aud":"","sub":"","email":"010101",
                    "email_verified":"true","iss":"","iat":"","exp": "1497531891",
                    "name":"sfsdfdr Ssdfev","picture":"","given_name":"Alsda",
                    "family_name":"Omsdfsv","locale":"","alg":"RS256",
                    "kid":""}', headers: {})
end

def stub_google_request_with_incorrect_token
  WebMock.stub_request(:get, /https:\/\/www\.googleapis\.com\/oauth2\/v3\/tokeninfo\?id_token=incorrect_token/)
         .with(headers: { 'Accept' => '*/*', 'Host' => 'www.googleapis.com', 'User-Agent' => 'Ruby' })
         .to_return(status: 200, body: '{error_description:"Error description"}')
end
