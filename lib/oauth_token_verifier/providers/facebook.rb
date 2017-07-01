# frozen_string_literal: true

module OauthTokenVerifier::Providers
  class Facebook
    BaseFields = Struct.new(:uid, :provider, :info)

    def initialize
      @data_fields = Struct.new(*config.fields_mapping.values)
      @request_fields = config.fields_mapping.keys.join(',')
    end

    def config
      OauthTokenVerifier.configuration.facebook
    end

    def verify_token(context)
      uri = build_uri(context.token)
      response = check_response(uri)
      parse_response(response)
    end

    private

    def build_uri(token)
      URI::HTTPS.build(host: 'graph.facebook.com',
                       path: '/me',
                       query: { access_token: token,
                                fields: @request_fields
                              }.to_query)
    end

    def check_response(uri)
      response = JSON.parse(Net::HTTP.get(uri))
      if error = response['error']
        raise TokenVerifier::TokenCheckError, error['message']
      else
        response
      end
    end

    def parse_response(data)
      BaseFields.new(
        data['id'],
        'facebook',
        @data_fields.new(
          *data.values_at(*config.fields_mapping.keys.map(&:to_s))
        )
      )
    end
  end
end
