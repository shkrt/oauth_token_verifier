require "oauth_token_verifier/version"
require "oauth_token_verifier/providers/google"
require "oauth_token_verifier/providers/vk"
require "oauth_token_verifier/providers/facebook"

module OauthTokenVerifier
  def verify(provider_name, payload)
    TokenVerifier.new(provider_name, payload[:token]).verify_token
  end

  class TokenVerifier
    attr_reader :token
    attr_accessor :provider

    class TokenCheckError < StandardError
      def initialize(msg)
        super(msg)
      end
    end

    def initialize(provider_name, token)
      @provider = find_provider(provider_name).new
      @token = token
    end

    def verify_token
      @provider.verify_token(self)
    end

    private

    def find_provider(name)
      "OauthTokenVerifier::Providers::#{name.to_s.camelize}".constantize
    end

  end
end
