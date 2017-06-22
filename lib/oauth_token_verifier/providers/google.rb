# frozen_string_literal: true
module OauthTokenVerifier::Providers
  class Google
    def verify_token(context)
      uri = build_uri(context.token)
      response = check_response(uri)
      parse_response(response)
    end

    private

    def build_uri(token)
      URI::HTTPS.build(host: 'www.googleapis.com',
                       path: '/oauth2/v3/tokeninfo',
                       query: { id_token: token }.to_query)
    end

    def check_response(uri)
      response = JSON.parse(Net::HTTP.get(uri))
      if error = response['error_description']
        raise OauthTokenVerifier::TokenCheckError, error
      else
        response
      end
    end

    # TODO: use PORO class instead of Ostruct, for performance's sake
    def parse_response(data)
      OpenStruct.new(
        uid: data['email'],
        provider: 'google_oauth2',
        info: OpenStruct.new(
          first_name: data['given_name'],
          last_name: data['family_name']
        )
      )
    end
  end
end
