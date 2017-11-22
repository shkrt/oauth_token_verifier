# frozen_string_literal: true

module OauthTokenVerifier
  module Providers
    class Google
      BaseFields = Struct.new(:uid, :provider, :info)

      def initialize
        @data_fields = Struct.new(*config.fields_mapping.values)
      end

      def verify_token(context)
        uri = build_uri(context.token)
        response = check_response(uri)
        parse_response(response)
      end

      private

      def config
        OauthTokenVerifier.configuration.google
      end

      def build_uri(token)
        params = { id_token: token }
        URI::HTTPS.build(host: 'www.googleapis.com',
                         path: '/oauth2/v3/tokeninfo',
                         query: URI.encode_www_form(params))
      end

      def check_response(uri)
        response = JSON.parse(Net::HTTP.get(uri))
        if error = response['error_description']
          raise OauthTokenVerifier::TokenVerifier::TokenCheckError, error
        else
          response
        end
      end

      def parse_response(data)
        BaseFields.new(
          data[config.id_field],
          config.name,
          @data_fields.new(
            *data.values_at(*config.fields_mapping.keys.map(&:to_s))
          )
        )
      end
    end
  end
end
