# frozen_string_literal: true

module OauthTokenVerifier::Providers
  class Vk
    BaseFields = Struct.new(:uid, :provider, :info)
    DataFields = Struct.new(:first_name, :last_name)

    def verify_token(context)
      uri = build_uri(context.token)
      response = check_response(uri)
      parse_response(response)
    end

    private

    def build_uri(token)
      URI::HTTPS.build(host: 'api.vk.com',
                       path: '/method/users.get',
                       query: { access_token: token }.to_query)
    end

    def check_response(uri)
      response = JSON.parse(Net::HTTP.get(uri))
      if error = response['error']
        raise TokenVerifier::TokenCheckError, error['error_msg']
      else
        response['response'].first
      end
    end

    def parse_response(data)
      BaseFields.new(
        uid: data['uid'],
        provider: 'vkontakte',
        info: DataFields.new(
          first_name: data['first_name'],
          last_name: data['last_name']
        )
      )
    end
  end
end
