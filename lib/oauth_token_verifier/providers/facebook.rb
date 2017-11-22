# frozen_string_literal: true

module OauthTokenVerifier
  module Providers
    class Facebook
      BaseFields = Struct.new(:uid, :provider, :info)

      def initialize
        @data_fields = Struct.new(*config.fields_mapping.values)
        @request_fields = config.fields_mapping.keys.join(',')
      end

      def verify_token(context)
        uri = build_uri(context.token)
        response = check_response(uri)
        parse_response(response)
      end

      private

      def config
        OauthTokenVerifier.configuration.facebook
      end

      def build_uri(token)
        params = { access_token: token, fields: @request_fields }
        URI::HTTPS.build(host: 'graph.facebook.com',
                         path: '/me',
                         query: URI.encode_www_form(params))
      end

      def check_response(uri)
        response = JSON.parse(Net::HTTP.get(uri))
        if error = response['error']
          raise OauthTokenVerifier::TokenVerifier::TokenCheckError, error['message']
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
