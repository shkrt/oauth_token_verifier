# frozen_string_literal: true
module OauthTokenVerifier::Providers
  class Facebook
    def verify_token(context)
      uri = build_uri(context.token)
      response = check_response(uri)
      parse_response(response)
    end

    private

    def build_uri(token)
      URI::HTTPS.build(host: 'graph.facebook.com',
                       path: '/me',
                       query: { access_token: token }.to_query)
    end

    def check_response(uri)
      response = JSON.parse(Net::HTTP.get(uri))
      if error = response['error']
        raise OauthTokenVerifier::TokenCheckError, error['message']
      else
        response
      end
    end

    # TODO: use PORO class instead of Ostruct, for performance's sake
    def parse_response(data)
      OpenStruct.new(
        uid: data['id'],
        provider: 'facebook',
        info: OpenStruct.new(
          name: data['name']
        )
      )
    end
  end
end
