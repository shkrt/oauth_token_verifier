# frozen_string_literal: true

module OauthTokenVerifier::Providers
  class Vk
    BaseFields = Struct.new(:uid, :provider, :info)

    def initialize
      @data_fields = Struct.new(*config.fields_mapping.values)
      @request_fields = config.fields_mapping.keys.join(',')
    end

    def config
      OauthTokenVerifier.configuration.vk
    end

    def verify_token(context)
      uri = build_uri(context.token)
      response = check_response(uri)
      parse_response(response)
    end

    private

    def build_uri(token)
      URI::HTTPS.build(host: 'api.vk.com',
                       path: '/method/users.get',
                       query: { access_token: token,
                                fields: @request_fields
                              }.to_query)
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
        data['uid'],
        'vkontakte',
        @data_fields.new(
          *data.values_at(*config.fields_mapping.keys.map(&:to_s))
        )
      )
    end
  end
end
